<?php

namespace App\Http\Controllers\Concerns;

use Illuminate\Http\Request;

trait ResolvesIncludes
{
    /**
     * Resolve allowed include values from the request.
     *
     * @param  array<int, string>  $allowed
     * @return array<int, string>
     */
    protected function resolveIncludes(Request $request, array $allowed): array
    {
        return collect(explode(',', (string) $request->query('include')))
            ->map(static fn (string $include): string => trim($include))
            ->filter()
            ->intersect($allowed)
            ->values()
            ->all();
    }
}
