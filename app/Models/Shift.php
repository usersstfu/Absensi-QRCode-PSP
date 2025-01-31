<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasTimestamps;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\Division;

class Shift extends Model
{
    use HasFactory, HasTimestamps;

    protected $fillable = [
        'name',
        'start_time',
        'end_time',
        'division_id',
        'work_days',
    ];
    
    protected $casts = [
    'work_days' => 'array',
    ];


    public function division()
    {
        return $this->belongsTo(Division::class, 'division_id', 'id');
    }
}
