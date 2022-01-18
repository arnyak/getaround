require_relative '../level4/main'

class Rental
    # Compute decreasing_rental_price_with_options
    def self.decreasing_rental_price_with_options(car, rental, options)
        (rental_options_amount(rental, options) + decreasing_rental_price(car, rental)).to_i
    end


    # Compute owner debit amount
    def self.owner_debit_amount_with_options(car, rental, options)
        options.keep_if {|opt| ['gps', 'baby_seat'].include?(opt)}
        owner_debit_amount(car, rental) + rental_options_amount(rental, options)
    end

    def self.drivy_fee_with_options(car, rental, options)
        options.keep_if {|opt| ['additional_insurance'].include?(opt)}
        drivy_fee(car, rental) + rental_options_amount(rental, options)
    end
    
    def self.compute_action_with_options(car, rental, options)
        [{
          who: "driver",
          type: "debit",
          amount: decreasing_rental_price_with_options(car, rental, options)
        },
        {
          who: "owner",
          type: "credit",
          amount: owner_debit_amount_with_options(car, rental, options)
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
          amount: drivy_fee_with_options(car, rental, options)
        }]
    end

    private
    def self.rental_options_amount(rental, options)
        options_amount = 0
        options_amount += option_gps_amount(rental) if options.include?('gps')
        options_amount += option_baby_seat_amount(rental) if options.include?('baby_seat')
        options_amount += option_additional_insurance_amount(rental) if options.include?('additional_insurance')
        options_amount
    end

    # Compute gps option amount
    def self.option_gps_amount(rental)
        (rental_period(rental) * 5 * 100).to_i
    end

    # Compute baby seat option amount
    def self.option_baby_seat_amount(rental)
        (rental_period(rental) * 2 * 100).to_i
    end

    # Compute additional_insurance option amount
    def self.option_additional_insurance_amount(rental)
        (rental_period(rental) * 10 * 100).to_i
    end
end

class Option
    def self.options
        begin
           JSON.parse(File.read(File.join(File.dirname(__FILE__), "data/input.json")))['options']
        rescue
            raise "Error when parsing the input.json file: #{e}"
        end
        
    end

    def self.find_rental_options(rental_id)
       options.select {|option| option['rental_id'] == rental_id}.map{|opt| opt['type']}
    end
end

def level5
    rentals_with_options_and_actions = []
    Rental.rentals.each do |rental|
        car = Car.car_by_id(rental['car_id'])

        rentals_with_options_and_actions << {id: rental['id'], options: Option.find_rental_options(rental['id']), actions: Rental.compute_action_with_options(car, rental, Option.find_rental_options(rental['id']))}
    end
    File.open(File.join(File.dirname(__FILE__), "data/expected_output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_options_and_actions}) }
end

level5