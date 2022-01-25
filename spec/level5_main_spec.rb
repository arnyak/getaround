require 'spec_helper'
require_relative '../level5/main'

describe 'level5' do

    before (:each) do 
        @rental = Rental.new({id: 3, car_id: 1, start_date: "2015-07-03", end_date: "2015-07-14", distance: 1000, driver_id: 2})
    end

    it 'should compute option gps amount' do 
        expect(@rental.option_gps_amount).to eq 6000
    end

    it 'should compute option baby seat amount' do 
        expect(@rental.option_baby_seat_amount).to eq 2400
    end

    it 'should compute option additional insurance amount' do 
        expect(@rental.option_additional_insurance_amount).to eq 12000
    end

    it 'should compute decreasing_rental_price_with_options amount for driver' do
        car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        rental = Rental.new( { id: 1, car_id: 1, start_date: "2015-12-8", end_date: "2015-12-8", distance: 100 })
        options = [ Option.new({id: 1, rental_id: 1,  type: "gps"}), Option.new({id: 2, rental_id: 1,  type: "baby_seat"})]


        expect(rental.decreasing_rental_price_with_options).to eq 3700
    end

    it 'should compute debit amount for owner' do
        car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        rental = Rental.new( { id: 1, car_id: 1, start_date: "2015-12-8", end_date: "2015-12-8", distance: 100 })
        options = [ Option.new({id: 1, rental_id: 1,  type: "gps"}), Option.new({id: 2, rental_id: 1,  type: "baby_seat"})]

        expect(rental.owner_debit_amount_with_options).to eq 2800
    end

    it 'should compute drivy_fee with options' do
        car = Car.new({id: 1, price_per_day: 2000, price_per_km: 10, user_id: 1})
        rental = Rental.new({id: 2, car_id: 1, start_date: "2015-03-31", end_date: "2015-04-01", distance: 300})
        options = [ Option.new({id: 3, rental_id: 2, type: "additional_insurance"})]

        expect(rental.drivy_fee_with_options).to eq (rental.drivy_fee + rental.option_additional_insurance_amount)
    end
end