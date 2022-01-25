require_relative '../level3/main'

def level4
    $level = "level4"

    rentals_with_actions = []
    Rental.find_all.each do |rental|
        rentals_with_actions << {id: rental.id, actions: Rental.compute_action(rental)}
    end
    File.open(File.join(File.dirname(__FILE__), "data/output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: rentals_with_actions}) }
end

level4