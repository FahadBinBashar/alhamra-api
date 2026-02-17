<?php

namespace App\Http\Resources;

use App\Models\Announcement;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/** @mixin Announcement */
class AnnouncementResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        $pivot = $this->pivot;

        return [
            'id' => $this->id,
            'title' => $this->title,
            'message' => $this->message,
            'image_url' => $this->image_url,
            'target_type' => $this->target_type,
            'target_ranks' => $this->target_ranks ?? [],
            'created_by' => $this->created_by,
            'creator_name' => $this->whenLoaded('creator', fn () => $this->creator?->name),
            'is_read' => $pivot ? (bool) $pivot->is_read : null,
            'read_at' => $pivot?->read_at,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
