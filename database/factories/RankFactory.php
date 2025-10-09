<?php

namespace Database\Factories;

use App\Models\Rank;
use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends Factory<\App\Models\Rank>
 */
class RankFactory extends Factory
{
    protected $model = Rank::class;

    public function definition(): array
    {
        return [
            'name' => $this->faker->unique()->jobTitle(),
            'code' => strtoupper($this->faker->unique()->lexify('???')),
            'description' => $this->faker->optional()->sentence(),
            'sort_order' => $this->faker->numberBetween(0, 50),
        ];
    }
}
