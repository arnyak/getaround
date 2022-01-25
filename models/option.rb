require_relative 'model_methods'
require_relative 'rental'


class Option
    include ModelMethods::InstanceMethods
    extend ModelMethods::ClassMethods

    attr_reader :id
    attr_accessor :rental_id, :type

    def initialize(attributes={})
        @id = attributes[:id].nil? ? Option.generate_id : attributes[:id]
        @type = attributes[:type]
        @rental_id = attributes[:rental_id]
    end

    def self.attributes
        [:id, :rental_id, :type]
    end

    def rental
        Rental.find_by_id(self.rental_id)
    end
end
