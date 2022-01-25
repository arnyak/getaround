require_relative '../level1/main'

def level2
    $level = "level2"
    File.open(File.join(File.dirname(__FILE__), "data/output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: Rental.find_all.map {|rental| {id: rental.id, price: rental.decreasing_rental_price} }}) }
end

level2