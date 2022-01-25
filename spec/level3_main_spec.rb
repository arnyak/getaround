require 'spec_helper'
require_relative '../level3/main'

describe 'level3' do 
    before (:each) do
        @car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        @rental =Rental.new({id: 3, car_id: 1, start_date: "2015-07-03", end_date: "2015-07-14", distance: 1000, driver_id: 2})
    end

    it 'should compute commisson' do 
        expect(@rental.commission).to eq (@rental.decreasing_rental_price * 0.3).to_i
    end

    it 'should compute insurance fee' do 
        expect(@rental.insurance_fee).to eq 4170
    end

    it 'should compute assistance fee' do 
        expect(@rental.assistance_fee).to eq 1200
    end

    it 'should compute drivy fee' do 
        expect(@rental.drivy_fee).to eq 2970
    end

end