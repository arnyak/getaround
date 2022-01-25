require_relative '../level2/main'

def level3
    $level = "level3"
    File.open(File.join(File.dirname(__FILE__), "data/output.json"),"w") { |f| f.write JSON.pretty_generate({rentals: Rental.find_all.map {|rental| {id: rental.id, price: rental.decreasing_rental_price, commisssion: {insurance_fee: rental.insurance_fee, assistance_fee: rental.assistance_fee, drivy_fee: rental.drivy_fee}}}}) }
end

level3