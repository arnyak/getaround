require 'spec_helper'
require_relative '../level5/main'

describe 'level5' do

    before (:each) do 
        @rental = {'id' => 3, 'car_id' => 1, 'start_date' => "2015-07-03", 'end_date' => "2015-07-14", 'distance' => 1000} 
    end

    it 'should compute option gps amount' do 

        expect(Rental.option_gps_amount(@rental)).to eq 6000
    end

    it 'should compute option baby seat amount' do 

        expect(Rental.option_baby_seat_amount(@rental)).to eq 2400
    end

    it 'should compute option additional insurance amount' do 

        expect(Rental.option_additional_insurance_amount(@rental)).to eq 12000
    end

    it 'should compute decreasing_rental_price_with_options amount for driver' do
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-08', 'end_date' => '2015-12-08', 'distance' => 100 }
        options = ['gps', 'baby_seat']

        expect(Rental.decreasing_rental_price_with_options(car, rental, options)).to eq 3700
    end

    it 'should compute debit amount for owner' do
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 1, 'car_id' => 1, 'start_date' => '2015-12-08', 'end_date' => '2015-12-08', 'distance' => 100 }
        options = ['gps', 'baby_seat']

        expect(Rental.owner_debit_amount_with_options(car, rental, options)).to eq 2800
    end
end