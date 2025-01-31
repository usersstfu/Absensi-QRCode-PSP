<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Concerns\HasTimestamps;
use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Barcode extends Model
{
    use HasFactory;
    use HasTimestamps;

    protected $fillable = [
        'name',
        'value',
        'latitude',
        'longitude',
        'radius',
        'division_id',
        'shift_id',
    ];

    /**
     * Get latitude and longitude as an array.
     *
     * @return array|null
     */
    public function getLatLngAttribute(): ?array
    {
        if (is_null($this->latitude) || is_null($this->longitude)) {
            return null;
        }
        return [
            'lat' => $this->latitude,
            'lng' => $this->longitude,
        ];
    }

    /**
     * Relation to the Division model.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function division()
    {
        return $this->belongsTo(Division::class, 'division_id');
    }

    /**
     * Relation to the Shift model.
     *
     * @return \Illuminate\Database\Eloquent\Relations\BelongsTo
     */
    public function shift()
    {
        return $this->belongsTo(Shift::class, 'shift_id');
    }

    /**
     * Check if a barcode is valid for the current shift and division.
     *
     * @param string $currentDay
     * @param int|null $shiftId
     * @return bool
     */
    public function isValidForShiftAndDivision(string $currentDay, ?int $shiftId): bool
    {
        if (!$this->shift || $this->shift_id !== $shiftId) {
            return false;
        }

        if (!in_array($currentDay, $this->shift->work_days)) {
            return false;
        }

        return true;
    }
}
