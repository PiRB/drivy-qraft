class ResponseGenerator
  OUTPUT_FILE_PATH = './data/output.json'

  def call
    rentals = generate_rentals_hash
    File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({"rentals": rentals}))}
  end

  private

  def generate_rentals_hash
    data_hash = read_data

    data_hash['rentals'].map do |rent|
      rental = Rent.new(rent:)
      car = data_hash['cars'].find { |car| car['id'] == rent['car_id'] }
      rent_car = Car.new(car:)

      rental.car = rent_car
      rental.price = Rents::Princing.new(rent: rental).call
      rental.commission = Commissions::Create.new(rent: rental).call

      {
        "id": rental.id,
        "price": rental.price,
        "commission": rental.commission.commission_hash
      }
    end
  end
end