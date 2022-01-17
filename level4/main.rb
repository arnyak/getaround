require_relative '../level3/main'

class Rental
    # Compute owner debit amount
    def self.owner_debit_amount(car, rental)
        decreasing_rental_price(car, rental) - commission(car, rental)
    end

    
    def self.compute_action(car, rental)
        [{
          who: "driver",
          type: "debit",
          amount: decreasing_rental_price(car, rental)
        },
        {
          who: "owner",
          type: "credit",
          amount: owner_debit_amount(car, rental)
        },
        {
          who: "insurance",
          type: "credit",
          amount: insurance_fee(car, rental)
        },
        {
          who: "assistance",
          type: "credit",
          amount: assistance_fee(car, rental)
        },
        {
          who: "drivy",
          type: "credit",
          amount: drivy_fee(car, rental)
        }]
    end
end

def level4
    rentals_with_actions = []
    Rental.rentals.each do |rental|
        car = Car.car_by_id(rental['car_id'])
        rentals_with_actions << {id: rental['id'], actions: Rental.compute_action(car, rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_actions}) }
end

level4