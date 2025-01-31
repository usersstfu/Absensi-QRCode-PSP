<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class FaceAttendance extends Model
{
    protected $fillable = [
        'user_name',
        'latitude',
        'longitude',
        'photo',
        'time_in',
    ];
}
