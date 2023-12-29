# frozen_string_literal: true
require 'json'
require 'date'

INPUT_FILE_PATH = './data/input.json'
OUTPUT_FILE_PATH = './data/output.json'
INPUT_FILE = File.read(INPUT_FILE_PATH)

File.open(OUTPUT_FILE_PATH, 'w')
HASH_DATA = JSON.parse(INPUT_FILE)

def compute_rent_days(rent)
  start_date = Date.parse(rent["start_date"])
  end_date =  Date.parse(rent["end_date"])

  return -1 if start_date > end_date

  return end_date - start_date + 1
end

def compute_rentals
  HASH_DATA['rentals'].map do |rental|
    car = HASH_DATA['cars'].find { |car| car['id'] == rental['car_id'] }
    rent_days = compute_rent_days(rental)
  
    rent_price = (rent_days * car['price_per_day'] + rental['distance'] * car['price_per_km']).to_i
    { "id": rental['id'], "price": rent_price}
  end
end

def output_data
  {
    "rentals": compute_rentals
  }
end

File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate(output_data))}