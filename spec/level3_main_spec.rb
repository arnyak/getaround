require 'spec_helper'
require_relative '../level3/main'

describe 'level3' do 
    before (:each) do
        @car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        @rental = {'id' => 3, 'car_id' => 1, 'start_date' => "2015-07-03", 'end_date' => "2015-07-14", 'distance' => 1000}
    end

    it 'should compute commisson' do 
        rental_price = Rental.decreasing_rental_price(@car, @rental)

        expect(Rental.commission(@car, @rental)).to eq (rental_price * 0.3).to_i
    end

    it 'should compute insurance fee' do 
        expect(Rental.insurance_fee(@car, @rental)).to eq 4170
    end

    it 'should compute assistance fee' do 
        expect(Rental.assistance_fee(@car, @rental)).to eq 1200
    end

    it 'should compute drivy fee' do 
        expect(Rental.drivy_fee(@car, @rental)).to eq 2970
    end

end