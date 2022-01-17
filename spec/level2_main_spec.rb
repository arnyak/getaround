require 'spec_helper'
require_relative '../level2/main'

describe 'level2' do 
    it 'should compute rental price amount' do
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 1, 'car_id' => 1, 'start_date' => "2017-12-08", 'end_date' => "2017-12-10", 'distance' => 100}

        expect(rental_price(car, rental)).to eq 7000
    end

    it 'should compute rental price amount for a decreasing pricing for longer rentals' do
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 3, 'car_id' => 1, 'start_date' => "2015-07-03", 'end_date' => "2015-07-14", 'distance' => 1000}

        expect(decreasing_rental_price(car, rental)).to eq 27800
    end
end