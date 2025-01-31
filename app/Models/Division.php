<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasTimestamps;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Shift;

class Division extends Model
{
    use HasFactory, HasTimestamps;

    protected $fillable = [
        'name',
        'timezone',
    ];

    public function shifts()
    {
        return $this->hasMany(Shift::class, 'division_id', 'id');
    }
}
