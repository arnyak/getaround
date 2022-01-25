require 'spec_helper'
require_relative '../level4/main'

describe 'level4' do 
    it 'should compute credit amount for owner' do 
        car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        rental =Rental.new({id: 3, car_id: 1, start_date: "2015-07-03", end_date: "2015-07-14", distance: 1000, driver_id: 2})

        expect(rental.owner_debit_amount).to eq 19460
    end
end