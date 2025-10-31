<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Lang;
use Illuminate\Validation\Rule;
use Illuminate\Validation\ValidationException;

class AuthController extends Controller
{
    /**
     * Register a new user and return an access token.
     */
    public function register(Request $request)
    {
        $data = $request->validate([
            'name' => ['required', 'string', 'max:255'],
            'email' => ['required', 'string', 'email', 'max:255', 'unique:users,email'],
            'password' => ['required', 'string', 'min:8'],
            'role' => ['required', 'string', Rule::in(User::ROLES)],
        ]);

        $user = User::create([
            'name' => $data['name'],
            'email' => $data['email'],
            'password' => Hash::make($data['password']),
            'role' => $data['role'],
        ]);

        $token = $user->createToken('api_token')->plainTextToken;

        return response()->json([
            'user' => $user,
            'token' => $token,
        ], 201);
    }

    /**
     * Authenticate an existing user and return an access token.
     */
    public function login(Request $request)
    {
        $credentials = $request->validate([
            'email' => ['required', 'string', 'email'],
            'password' => ['required', 'string'],
            'role' => ['sometimes', 'string', Rule::in(User::ROLES)],
        ]);

        $user = User::where('email', $credentials['email'])->first();

        if (! $user || ! Hash::check($credentials['password'], $user->password)) {
            throw ValidationException::withMessages([
                'email' => [Lang::get('auth.failed')],
            ]);
        }

        if (isset($credentials['role']) && $user->role !== $credentials['role']) {
            throw ValidationException::withMessages([
                'role' => [Lang::get('auth.failed')],
            ]);
        }

        $relationsToLoad = [];

        if ($user->role === User::ROLE_AGENT) {
            $relationsToLoad[] = 'agent';
        }

        if ($user->role === User::ROLE_EMPLOYEE) {
            $relationsToLoad[] = 'employee';
        }

        if (! empty($relationsToLoad)) {
            $user->loadMissing($relationsToLoad);
        }

        $userData = $user->toArray();

        if ($user->relationLoaded('agent') && $user->agent) {
            $userData['agent_id'] = $user->agent->id;
        }

        $token = $user->createToken('api_token')->plainTextToken;

        return response()->json([
            'user' => $userData,
            'token' => $token,
        ]);
    }

    /**
     * Revoke the current access token for the authenticated user.
     */
    public function logout(Request $request)
    {
        $user = $request->user();

        if ($user && $user->currentAccessToken()) {
            $user->currentAccessToken()->delete();
        }

        return response()->json([
            'message' => 'Logged out successfully.',
        ]);
    }
    public function changePassword(Request $request)
    {
        // Validate input data
        $data = $request->validate([
            'current_password' => ['required', 'string'],
            'new_password' => ['required', 'string', 'min:8', 'confirmed'], // 'confirmed' assumes 'new_password_confirmation' is provided
        ]);

        // Get the currently authenticated user
        $user = $request->user();

        // Check if the current password matches
        if (! Hash::check($data['current_password'], $user->password)) {
            throw ValidationException::withMessages([
                'current_password' => ['The provided password does not match our records.'],
            ]);
        }

        // Update the password
        $user->password = Hash::make($data['new_password']);
        $user->save();

        // Optionally, invalidate any existing tokens (if you want the user to log in again after changing the password)
        $user->tokens->each(function ($token) {
            $token->delete();
        });

        return response()->json([
            'message' => 'Password updated successfully.',
        ]);
    }
}
