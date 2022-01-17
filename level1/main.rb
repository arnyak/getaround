require 'json'
require 'date'

def cars
    _cars = []
    begin
        _cars = JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['cars']
    rescue JSON::ParserError => e
        raise "Error when parsing the input.json file: #{e}"
    end
    _cars
end

def rentals
    _rentals = []
    begin
        _rentals = JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['rentals']
    rescue JSON::ParserError => e
        raise "Error when parsing the input.json file: #{e}"
    end
    _rentals 
end

def get_car_by_id(car_id)
    cars.find { |car| car['id'] == car_id }
end

def rental_price(car, rental)
    rental_period = (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1
    car['price_per_day']*rental_period + car['price_per_km']*rental['distance']
end

def level1
    rentals_with_prices = []
    rentals.each do |rental|
        car = get_car_by_id(rental['car_id'])
        rentals_with_prices << {id: rental['id'], price: rental_price(car, rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_prices}) }
end

level1