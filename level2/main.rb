require_relative '../level1/main'

class Rental 
    # Get all rentals for level2
    def self.rentals
        begin
            JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['rentals']
        rescue JSON::ParserError => e
            raise "Error when parsing the input.json file: #{e}"
        end
    end

    # Compute decreasing rental price
    def self.decreasing_rental_price(car, rental)
        decreased_rental_price = case rental_period(rental)
            when 1 then car['price_per_day']
            when 1..4 then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i
            when 4..10 then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i + (car['price_per_day'] * 6 * 0.7).to_i
            when 10.. then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i + (car['price_per_day'] * 6 * 0.7).to_i + (car['price_per_day'] * (rental_period(rental) - 10) * 0.5).to_i
        end
    
        decreased_rental_price + (car['price_per_km']*rental['distance']).to_i
    end

    private
    def self.rental_period(rental)
        (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1
    end
end

def level2
    rentals_with_decreasing_prices = []
    Rental.rentals.each do |rental|
        car = Car.car_by_id(rental['car_id'])
        rentals_with_decreasing_prices << {id: rental['id'], price: Rental.decreasing_rental_price(car, rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_decreasing_prices}) }
end

level2