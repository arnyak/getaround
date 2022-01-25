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
end