class ResponseGenerator

  INPUT_FILE_PATH = './data/input.json'
  OUTPUT_FILE_PATH = './data/output.json'
  INPUT_FILE = File.read(INPUT_FILE_PATH)
  DATA_HASH = JSON.parse(INPUT_FILE)

  def call
    rentals = generate_rentals_hash
    File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({"rentals": rentals}))}
  end

  private

  def generate_rentals_hash
    DATA_HASH['rentals'].map do |rent|
      rental = Rent.new(rent:)
      car = DATA_HASH['cars'].find { |car| car['id'] == rent['car_id'] }
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