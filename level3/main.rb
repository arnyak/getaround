require_relative '../level2/main'

class Rental
    # Compute commision amount
    def self.commission(car, rental)
        (decreasing_rental_price(car, rental) * 0.3).to_i
    end

    # Compute insurance_fee amount
    def self.insurance_fee(car, rental)
        (commission(car, rental) * 0.5).to_i
    end
    
    # Compute assistance_fee amount
    def self.assistance_fee(car, rental)
        (rental_period(rental) * 100).to_i
    end

    # Compute drivy_fee amount
    def self.drivy_fee(car, rental)
        (commission(car, rental) - (insurance_fee(car, rental) + assistance_fee(car, rental))).to_i
    end
end

def level3
    rentals_with_fees = []
    Rental.rentals.each do |rental|
        car = Car.car_by_id(rental['car_id'])
        rentals_with_fees << {id: rental['id'], price: Rental.decreasing_rental_price(car, rental), commisssion: {insurance_fee: Rental.insurance_fee(car, rental), assistance_fee: Rental.assistance_fee(car, rental), drivy_fee: Rental.drivy_fee(car, rental)}}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_fees}) }
end

level3