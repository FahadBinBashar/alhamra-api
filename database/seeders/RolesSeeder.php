<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Spatie\Permission\Models\Permission;
use Spatie\Permission\Models\Role;

class RolesSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $permissions = [
            'manage users',
            'manage branches',
            'manage agents',
            'manage products',
            'manage services',
            'manage sales orders',
            'manage payments',
            'manage commissions',
            'manage ranks',
            'manage accounting',
            'view reports',
        ];

        $permissionModels = collect($permissions)->mapWithKeys(function (string $name) {
            $permission = Permission::firstOrCreate(
                ['name' => $name, 'guard_name' => 'web']
            );

            return [$name => $permission];
        });

        $roles = [
            'admin' => $permissions,
            'finance' => ['manage payments', 'manage commissions', 'manage accounting', 'view reports'],
            'branch-manager' => ['manage agents', 'manage sales orders', 'manage payments', 'view reports'],
            'agent' => ['manage sales orders', 'view reports'],
            'director' => ['manage ranks', 'manage commissions', 'view reports'],
            'owner' => ['view reports'],
            'customer' => [],
        ];

        foreach ($roles as $roleName => $rolePermissions) {
            $role = Role::firstOrCreate(
                ['name' => $roleName, 'guard_name' => 'web']
            );

            $role->syncPermissions($permissionModels->only($rolePermissions)->values());
        }
    }
}
