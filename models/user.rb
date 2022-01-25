require_relative 'model_methods'

class User 
    include ModelMethods::InstanceMethods
    extend ModelMethods::ClassMethods
    
    attr_reader :id
    attr_accessor :first_name, :last_name, :who

    def initialize(attributes = {})
        @id = attributes[:id].nil? ? User.generate_id : attributes[:id]
        @first_name = attributes[:first_name]
        @last_name = attributes[:last_name]
    end

   
    def self.validate(user)
        if user.first_name != "" and user.last_name != ""
            true
        else
            raise "user not valid"
        end
    end

    def self.attributes
        [:id, :first_name, :last_name, :who]
    end

    def cars
        Car.find_all_by('user_id', self.id)        
    end

    def rentals
        Rental.find_all_by('driver_id', self.driver_id)        
    end
end