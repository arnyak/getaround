require_relative '../level4/main'

def level5
    $level = "level5"

    rentals_with_options_and_actions = []
    Rental.find_all.each do |rental|
        rentals_with_options_and_actions << {id: rental.id, options: rental.options.map(&:type), actions: Rental.compute_action_with_options(rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_options_and_actions}) }
end

level5