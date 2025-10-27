<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin \App\Models\User
 */
class UserResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        return [
            'id' => $this->id,
            'name' => $this->name,
            'email' => $this->email,
            'role' => $this->role,
            'father_name' => $this->father_name,
            'mother_name' => $this->mother_name,
            'marital_status' => $this->marital_status,
            'spouse_name' => $this->spouse_name,
            'profession' => $this->profession,
            'permanent_address' => $this->permanent_address,
            'present_address' => $this->present_address,
            'contact_number' => $this->contact_number,
            'residence_phone' => $this->residence_phone,
            'whatsapp_number' => $this->whatsapp_number,
            'national_id' => $this->national_id,
            'passport_number' => $this->passport_number,
            'nationality' => $this->nationality,
            'religion' => $this->religion,
            'date_of_birth' => $this->date_of_birth,
            'blood_group' => $this->blood_group,
            'nominee_name' => $this->nominee_name,
            'nominee_relation' => $this->nominee_relation,
            'nominee_phone' => $this->nominee_phone,
            'authorized_person_name' => $this->authorized_person_name,
            'authorized_person_address' => $this->authorized_person_address,
            'joint_applicants' => $this->joint_applicants,
            'added_by_role' => $this->added_by_role,
            'added_by_branch_id' => $this->added_by_branch_id,
            'added_by_agent_id' => $this->added_by_agent_id,
            'created_at' => $this->created_at,
            'updated_at' => $this->updated_at,
        ];
    }
}
