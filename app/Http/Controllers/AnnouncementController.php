<?php

namespace App\Http\Controllers;

use App\Http\Resources\AnnouncementResource;
use App\Models\Announcement;
use App\Models\AnnouncementUser;
use App\Models\Employee;
use App\Models\Rank;
use App\Models\User;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\AnonymousResourceCollection;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\Rule;

class AnnouncementController extends Controller
{
    public function index(Request $request): AnonymousResourceCollection
    {
        $this->ensureAdmin($request->user());

        $query = Announcement::query()->with('creator');

        if ($request->filled('target_type')) {
            $query->where('target_type', $request->string('target_type')->toString());
        }

        $announcements = $query
            ->orderByDesc('created_at')
            ->paginate($request->integer('per_page', 15))
            ->appends($request->query());

        return AnnouncementResource::collection($announcements);
    }

    public function store(Request $request): JsonResponse
    {
        $user = $request->user();
        $this->ensureAdmin($user);

        $data = $request->validate([
            'title' => ['required', 'string', 'max:255'],
            'message' => ['required', 'string'],
            'target_type' => ['required', Rule::in([Announcement::TARGET_ALL, Announcement::TARGET_RANK_WISE])],
            'target_ranks' => ['nullable', 'array'],
            'target_ranks.*' => ['integer', Rule::exists('ranks', 'id')],
            'image' => ['nullable', 'file', 'image', 'max:5120'],
        ]);

        if ($data['target_type'] === Announcement::TARGET_RANK_WISE && empty($data['target_ranks'])) {
            abort(422, 'target_ranks is required when target_type is rank_wise.');
        }

        $announcement = DB::transaction(function () use ($data, $request, $user) {
            $imageUrl = $this->storeImage($request->file('image'));

            $announcement = Announcement::create([
                'title' => $data['title'],
                'message' => $data['message'],
                'target_type' => $data['target_type'],
                'target_ranks' => $data['target_type'] === Announcement::TARGET_RANK_WISE
                    ? array_values(array_unique(array_map('intval', $data['target_ranks'] ?? [])))
                    : null,
                'image_url' => $imageUrl,
                'created_by' => $user->id,
            ]);

            $recipientUserIds = $this->resolveRecipientUserIds($announcement);

            $rows = $recipientUserIds
                ->map(fn (int $userId) => [
                    'announcement_id' => $announcement->id,
                    'user_id' => $userId,
                    'is_read' => false,
                    'read_at' => null,
                    'created_at' => now(),
                    'updated_at' => now(),
                ])
                ->all();

            if (! empty($rows)) {
                AnnouncementUser::insert($rows);
            }

            return $announcement;
        });

        return response()->json([
            'data' => new AnnouncementResource($announcement->load('creator')),
        ], 201);
    }

    public function show(Request $request, Announcement $announcement): AnnouncementResource
    {
        $user = $request->user();

        if (in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            return new AnnouncementResource($announcement->load('creator'));
        }

        $mapped = Announcement::query()
            ->whereKey($announcement->id)
            ->whereHas('users', function (Builder $builder) use ($user) {
                $builder->where('users.id', $user->id);
            })
            ->with([
                'creator',
                'users' => function ($query) use ($user) {
                    $query->where('users.id', $user->id);
                },
            ])
            ->firstOrFail();

        $mapped->setRelation('pivot', $mapped->users->first()?->pivot);

        return new AnnouncementResource($mapped);
    }

    public function employeeAnnouncements(Request $request): AnonymousResourceCollection
    {
        $user = $request->user();

        $query = $user->announcements()
            ->with('creator')
            ->orderByDesc('announcements.created_at');

        if ($request->boolean('unread_only')) {
            $query->wherePivot('is_read', false);
        }

        $announcements = $query
            ->paginate($request->integer('per_page', 10))
            ->appends($request->query());

        return AnnouncementResource::collection($announcements);
    }

    public function unreadCount(Request $request): JsonResponse
    {
        $count = AnnouncementUser::query()
            ->where('user_id', $request->user()->id)
            ->where('is_read', false)
            ->count();

        return response()->json(['unread_count' => $count]);
    }

    public function markAsRead(Request $request, Announcement $announcement): JsonResponse
    {
        $updated = AnnouncementUser::query()
            ->where('announcement_id', $announcement->id)
            ->where('user_id', $request->user()->id)
            ->update([
                'is_read' => true,
                'read_at' => Carbon::now(),
                'updated_at' => Carbon::now(),
            ]);

        if (! $updated) {
            abort(404, 'Announcement not found for current user.');
        }

        return response()->json(['message' => 'Marked as read.']);
    }

    protected function resolveRecipientUserIds(Announcement $announcement)
    {
        $targetRankCodes = [];

        if ($announcement->target_type === Announcement::TARGET_RANK_WISE) {
            $targetRankCodes = Rank::query()
                ->whereIn('id', $announcement->target_ranks ?? [])
                ->pluck('code')
                ->all();
        }

        return Employee::query()
            ->whereHas('user', fn (Builder $builder) => $builder->where('role', User::ROLE_EMPLOYEE))
            ->when($announcement->target_type === Announcement::TARGET_RANK_WISE, function (Builder $builder) use ($targetRankCodes) {
                $builder->whereIn('rank', $targetRankCodes);
            })
            ->pluck('user_id')
            ->filter()
            ->unique()
            ->values();
    }

    protected function storeImage(?UploadedFile $image): ?string
    {
        if (! $image) {
            return null;
        }

        $disk = config('filesystems.default');
        $path = $image->store('announcements', $disk);

        return $disk . ':' . $path;
    }

    protected function ensureAdmin(?User $user): void
    {
        if (! $user || ! in_array($user->role, [User::ROLE_ADMIN, User::ROLE_BRANCH_ADMIN], true)) {
            abort(403, 'Only administrators can manage announcements.');
        }
    }
}
