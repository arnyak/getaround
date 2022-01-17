require 'json'
require 'date'

class Car
    # Get all cars
    def self.cars
        begin
            JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['cars']
        rescue JSON::ParserError => e
            raise "Error when parsing the input.json file: #{e}"
        end
    end

    # Get One car 
    def self.car_by_id(car_id)
        cars.find { |car| car['id'] == car_id }
    end
end

class Rental
    # Get all rentals
    def self.rentals
        begin
            JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['rentals']
        rescue JSON::ParserError => e
            raise "Error when parsing the input.json file: #{e}"
        end
    end

    # Compute rental price
    def self.rental_price(car, rental)
        rental_period = (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1
        car['price_per_day']*rental_period + car['price_per_km']*rental['distance']
    end
end

# prepare and generate ouputfile json file
def level1
    rentals_with_prices = []
    Rental.rentals.each do |rental|
        car = Car.car_by_id(rental['car_id'])
        rentals_with_prices << {id: rental['id'], price: Rental.rental_price(car, rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_prices}) }
end

level1