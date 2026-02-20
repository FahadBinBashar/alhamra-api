<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});
Route::get('/cache-clear', function () {
    // 1. Clears Views, Config, Routes, and Compiled Services in one go
    Artisan::call('optimize:clear');
    
    // 2. Clears the actual Application Cache (Redis/File/Database data)
    Artisan::call('cache:clear');
    
    // 3. Clears Event Discovery cache
    Artisan::call('event:clear');
    
    // 4. Clears expired password reset tokens from the database
    Artisan::call('auth:clear-resets');

    return response()->json([
        'status' => 'success',
        'message' => 'The application is now 100% fresh.',
        'details' => [
            'optimization' => 'Config, routes, and views cleared',
            'cache'        => 'Application data cache flushed',
            'events'       => 'Event discovery refreshed',
            'auth'         => 'Expired reset tokens removed'
        ]
    ]);
});