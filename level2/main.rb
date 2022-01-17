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
    (car['price_per_day']*rental_period(rental) + car['price_per_km']*rental['distance']).to_i
end

def rental_period(rental)
    (Date.parse(rental['end_date']) - Date.parse(rental['start_date'])).to_i + 1
end

def decreasing_rental_price(car, rental)
    decreased_rental_price = case rental_period(rental)
        when 1 then car['price_per_day']
        when 1..4 then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i
        when 4..10 then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i + (car['price_per_day'] * 6 * 0.7).to_i
        when 10.. then car['price_per_day'] + (car['price_per_day'] * 3 * 0.9).to_i + (car['price_per_day'] * 6 * 0.7).to_i + (car['price_per_day'] * (rental_period(rental) - 10) * 0.5).to_i
    end

    decreased_rental_price + (car['price_per_km']*rental['distance'])
end

def level2
    rentals_with_decreasing_prices = []
    rentals.each do |rental|
        car = get_car_by_id(rental['car_id'])
        rentals_with_decreasing_prices << {id: rental['id'], price: decreasing_rental_price(car, rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_decreasing_prices}) }
end

level2