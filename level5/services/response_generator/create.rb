module ResponseGenerator
  class Create
    OUTPUT_FILE_PATH = './data/output.json'
  
    def call
      rentals = generate_rentals_hash
      File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({'rentals': rentals}))}
    end
  
    private
  
    def generate_rentals_hash
      data_hash = read_data

      data_hash['rentals'].map do |rent|
      
        rental = Rent.new(rent:)
        car = data_hash['cars'].find { |car| car['id'] == rent['car_id'] }
        rent_car = Car.new(car:)

        options = data_hash['options'].select { |option| option['rental_id'] == rental.id }

        rental.options = options.map { |option| Option.new(option:)}
  
        rental.car = rent_car
        rental.price = Rents::Princing.new(rent: rental).call
        rental.commission = Commissions::Create.new(rent: rental).call
        rental.actions = Actions::Create.new(rent: rental).call
        {
          'id': rental.id,
          'options': prepare_options(rent: rental),
          'actions': prepare_actions(rent: rental)
        }
      end
    end

    def prepare_actions(rent:)
      rent.actions.map { |action| action.action_hash }
    end

    def prepare_options(rent:)
      rent.options.map { |option| option.type }
    end
  end
end