require 'spec_helper'
require_relative '../level1/main'

describe 'level1' do 
    it 'should compute renatl price amount' do
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 1, 'car_id' => 1, 'start_date' => "2017-12-08", 'end_date' => "2017-12-10", 'distance' => 100}

        expect(Rental.rental_price(car, rental)).to eq 7000
    end
end