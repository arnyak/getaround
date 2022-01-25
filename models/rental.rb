require 'date'
require_relative 'model_methods'
require_relative 'user'
require_relative 'car'



class Rental

    include ModelMethods::InstanceMethods
    extend ModelMethods::ClassMethods
    
    attr_reader :id
    attr_accessor :car_id, :start_date, :end_date, :distance, :driver_id


    def initialize(attributes = {})
        @id = attributes[:id].nil? ? Rental.generate_id : attributes[:id]
        @car_id = attributes[:car_id]
        @start_date = attributes[:start_date]
        @end_date = attributes[:end_date]
        @distance = attributes[:distance]
        @driver_id = attributes[:driver_id]
    end

   
    def self.validate(rental)
        if rental.car_id.to_i > 0 and rental.start_date != "" and rental.end_date != "" 
            true
        else
            raise "Rental not valid"
        end
    end

    def self.attributes
        [:id, :car_id, :start_date, :end_date, :distance, :driver_id]
    end

    # Get the cr on the rental
    def car
        Car.find_by_id(self.car_id)
    end

    def driver
        Driver.find_by_id(self.driver_id)
    end

    # Compute rental price
    def rental_price
        rental_period = (Date.parse(self.end_date) - Date.parse(self.start_date)).to_i + 1
        self.car.price_per_day*rental_period + self.car.price_per_km*self.distance
    end

    # Compute decreasing rental price
    def decreasing_rental_price
        decreased_rental_price = case self.rental_period
            when 1 then self.car.price_per_day
            when 1..4 then self.car.price_per_day + (self.car.price_per_day * 3 * 0.9).to_i
            when 4..10 then self.car.price_per_day + (self.car.price_per_day * 3 * 0.9).to_i + (self.car.price_per_day * 6 * 0.7).to_i
            when 10.. then self.car.price_per_day + (self.car.price_per_day * 3 * 0.9).to_i + (self.car.price_per_day * 6 * 0.7).to_i + (self.car.price_per_day * (self.rental_period - 10) * 0.5).to_i
        end
    
        decreased_rental_price + (self.car.price_per_km*self.distance).to_i
    end

    def rental_period
        (Date.parse(self.end_date) - Date.parse(self.start_date)).to_i + 1
    end
end