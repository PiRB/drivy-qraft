# frozen_string_literal: true
require 'json'
require 'date'

INPUT_FILE_PATH = './data/input.json'
OUTPUT_FILE_PATH = './data/output.json'
INPUT_FILE = File.read(INPUT_FILE_PATH)

File.open(OUTPUT_FILE_PATH, 'w')
HASH_DATA = JSON.parse(INPUT_FILE)

def compute_rent_days(rent:)
  start_date = Date.parse(rent['start_date'])
  end_date =  Date.parse(rent['end_date'])

  return -1 if start_date > end_date

  return end_date - start_date + 1
end

def compute_rent_pricing(car:, rent:)
  return 0 if compute_rent_days(rent:) == 0
  rent_days = compute_rent_days(rent:)
  case rent_days
  when 5..10
    rent_price = car['price_per_day'] + 3 * car['price_per_day'] * 0.9 + (rent_days - 4) * car['price_per_day'] * 0.7
  when 2..4
    rent_price = car['price_per_day'] + (rent_days - 1) * car['price_per_day'] * 0.9
  when 1
    rent_price = car['price_per_day'] 
  else
    rent_price = car['price_per_day'] + 3 * car['price_per_day'] * 0.9 + 6 * car['price_per_day'] * 0.7 + (rent_days - 10) * car['price_per_day'] * 0.5
  end

  rent_price += rent['distance'] * car['price_per_km'].to_i
end

def compute_rentals
  HASH_DATA['rentals'].map do |rent|
    car = HASH_DATA['cars'].find { |car| car['id'] == rent['car_id'] }

    rent_price = compute_rent_pricing(car:, rent:)

    { "id": rent['id'], "price": rent_price}
  end
end

def output_data
  {
    "rentals": compute_rentals
  }
end

File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate(output_data))}