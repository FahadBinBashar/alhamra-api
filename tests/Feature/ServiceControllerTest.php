<?php

namespace Tests\Feature;

use App\Models\Category;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Laravel\Sanctum\Sanctum;
use Tests\TestCase;

class ServiceControllerTest extends TestCase
{
    use RefreshDatabase;

    public function test_service_create_and_update_include_commission_percentage(): void
    {
        $admin = User::factory()->create(['role' => User::ROLE_ADMIN]);
        Sanctum::actingAs($admin);

        $category = Category::create([
            'name' => 'Service Category',
            'type' => 'service',
        ]);

        $response = $this->postJson('/api/v1/services', [
            'category_id' => $category->id,
            'name' => 'Premium Concierge',
            'price' => 15000,
            'commission_percentage' => 5.5,
            'attributes' => ['duration' => '3 nights'],
        ]);

        $response->assertCreated();
        $response->assertJsonPath('data.commission_percentage', '5.50');

        $serviceId = $response->json('data.id');

        $this->assertDatabaseHas('services', [
            'id' => $serviceId,
            'commission_percentage' => '5.50',
        ]);

        $update = $this->patchJson("/api/v1/services/{$serviceId}", [
            'commission_percentage' => 12,
        ]);

        $update->assertOk();
        $update->assertJsonPath('data.commission_percentage', '12.00');

        $this->assertDatabaseHas('services', [
            'id' => $serviceId,
            'commission_percentage' => '12.00',
        ]);

        $index = $this->getJson('/api/v1/services');
        $index->assertOk();
        $index->assertJsonPath('data.0.commission_percentage', '12.00');
    }
}
