<?php

namespace App\Models;

use App\Traits\LogsActivityChanges;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class CommissionSetting extends Model
{
    use HasFactory;
    use LogsActivityChanges;

    protected $fillable = [
        'key',
        'value',
    ];

    protected static array $cache = [];

    protected static function booted(): void
    {
        static::saved(function (self $setting): void {
            unset(static::$cache[$setting->key]);
        });

        static::deleted(function (self $setting): void {
            unset(static::$cache[$setting->key]);
        });
    }

    public function getValueAttribute($value): mixed
    {
        if ($value === null) {
            return null;
        }

        $decoded = json_decode($value, true);

        return json_last_error() === JSON_ERROR_NONE ? $decoded : $value;
    }

    public function setValueAttribute(mixed $value): void
    {
        $this->attributes['value'] = json_encode($value, JSON_THROW_ON_ERROR);
    }

    public static function value(string $key, mixed $default = null): mixed
    {
        if (array_key_exists($key, static::$cache)) {
            return static::$cache[$key];
        }

        $setting = static::query()->where('key', $key)->first();

        return static::$cache[$key] = $setting?->value ?? $default;
    }
}
