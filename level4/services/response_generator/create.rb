module ResponseGenerator
  class Create
    INPUT_FILE_PATH = './data/input.json'
    OUTPUT_FILE_PATH = './data/output.json'
    INPUT_FILE = File.read(INPUT_FILE_PATH)
    DATA_HASH = JSON.parse(INPUT_FILE)
  
    def call
      rentals = compute_rentals
      File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({"rentals": rentals}))}
    end
  
    private
  
    def compute_rentals
      DATA_HASH['rentals'].map do |rent|
        new_rent = Rent.new(
          :id => rent['id'],
          :start_date => rent['start_date'],
          :end_date => rent['end_date'],
          :distance => rent['distance']
        )
        car = DATA_HASH['cars'].find { |car| car['id'] == rent['car_id'] }
  
        new_car = Car.new(
          :id => car['id'],
          :price_per_day => car['price_per_day'],
          :price_per_km => car['price_per_km']
        )
  
        new_rent.car = new_car
        new_rent.price = new_rent.compute_pricing
        new_rent.commission = Commissions::Create.new(rent: new_rent).call
        new_rent.actions = Actions::Create.new(rent: new_rent).call
  
        actions = new_rent.actions.map { |action| action.action_hash }

        {
          "id": new_rent.id,
          "actions": actions
        }
      end
    end
  end
end