require 'spec_helper'
require_relative '../level1/main'

describe 'level1' do 
    it 'should compute rental price amount' do
        car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        rental = Rental.new({id: 1, car_id: 1, start_date: "2017-12-8", end_date: "2017-12-10", distance: 100, driver_id: 2})

        expect(rental.rental_price).to eq 7000
    end
end