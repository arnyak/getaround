require 'spec_helper'
require_relative '../level4/main'

describe 'level4' do 
    it 'should compute credit amount for owner' do 
        car = {'id' => 1, 'price_per_day' => 2000, 'price_per_km' => 10}
        rental = {'id' => 3, 'car_id' => 1, 'start_date' => "2015-07-03", 'end_date' => "2015-07-14", 'distance' => 1000}

        expect(Rental.owner_debit_amount(car, rental)).to eq 19460
    end
end