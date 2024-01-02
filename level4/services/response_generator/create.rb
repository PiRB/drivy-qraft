module ResponseGenerator
  class Create
    INPUT_FILE_PATH = './data/input.json'
    OUTPUT_FILE_PATH = './data/output.json'
    INPUT_FILE = File.read(INPUT_FILE_PATH)
    DATA_HASH = JSON.parse(INPUT_FILE)
  
    def call
      rentals = generate_rentals_hash
      File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({ "rentals": rentals }))}
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
        rental.actions = Actions::Create.new(rent: rental).call
  
        actions = rental.actions.map { |action| action.action_hash }

        {
          "id": rental.id,
          "actions": actions
        }
      end
    end
  end
end