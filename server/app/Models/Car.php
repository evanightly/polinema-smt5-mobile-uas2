<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use App\Models\CarBrand;
use App\Models\CarBodyType;
use App\Models\CarFuel;

class Car extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'brand', // ['Toyota', 'Honda', 'Suzuki', 'Mitsubishi', 'Daihatsu', 'Mazda', 'Nissan', 'Mercedes-Benz', 'BMW', 'Audi', 'Lexus', 'Isuzu']
        'body_type', // ['SUV', 'Sedan', 'Hatchback', 'MPV', 'Wagon']
        'year',
        'km_min', // 'km_min' and 'km_max' are used to determine the range of km
        'km_max',
        'fuel', // ['Pertamax', 'Solar']
        'price',
        'image',
        'description',
        'condition', // ['Used', 'New']
        'transmission', // ['Automatic', 'Manual']
        'status' // ['Available', 'Sold']
    ];

    public function brand()
    {
        return $this->hasOne(CarBrand::class, 'id', 'brand_id');
    }

    public function bodyType()
    {
        return $this->hasOne(CarBodyType::class, 'id', 'body_type_id');
    }

    public function fuel()
    {
        return $this->hasOne(CarFuel::class, 'id', 'fuel_id');
    }
}
