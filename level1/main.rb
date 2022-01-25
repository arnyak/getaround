require_relative 'models/rental'

Dir.glob(File.join(__dir__, '../models/*.rb')).each {|f| require_relative f }

# prepare and generate ouputfile json file
def level1
    File.open(File.join(File.dirname(__FILE__), "data/output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: Rental.find_all.map{|rental| {id: rental.id, price: rental.rental_price}}}) }
end

level1