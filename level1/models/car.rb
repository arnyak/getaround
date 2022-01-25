require_relative 'model_methods'
require_relative 'user'


class Car
    include ModelMethods::InstanceMethods
    extend ModelMethods::ClassMethods

    attr_reader :id
    attr_accessor :price_per_day, :price_per_km, :owner_id

    def initialize(attributes={})
        @id = attributes[:id].nil? ? Car.generate_id : attributes[:id]
        @price_per_day = attributes[:price_per_day]
        @price_per_km = attributes[:price_per_km]
        @owner_id = attributes[:owner_id]
    end
    
    def self.validate(car)
        if car.price_per_day.to_i > 0 and car.price_per_km.to_i > 0 and !User.find_by_id(car.owner_id).nil?
            true
        else
            raise "Car not valid"
        end
    end

    def self.attributes
        [:id, :price_per_day, :price_per_km, :owner_id]
    end

    def owner
        User.find_by_id(self.owner_id)
    end
end
