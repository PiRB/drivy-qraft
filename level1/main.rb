# frozen_string_literal: true
require 'json'
require 'date'
require '../lib/rent_days'

INPUT_FILE_PATH = './data/input.json'
OUTPUT_FILE_PATH = './data/output.json'
INPUT_FILE = File.read(INPUT_FILE_PATH)

File.open(OUTPUT_FILE_PATH, 'w')
HASH_DATA = JSON.parse(INPUT_FILE)

def days_rent_price(rent:, price_per_day:)
  rent_days = compute_rent_days(rent)

  rent_days * price_per_day
end

def distance_rent_price(distance:, price_per_km:)
  distance * price_per_km
end

def generate_rentals_hash
  HASH_DATA['rentals'].map do |rental|
    car = HASH_DATA['cars'].find { |car| car['id'] == rental['car_id'] }
    days_price = days_rent_price(rent: rental, price_per_day: car['price_per_day'])
    distance_price = distance_rent_price(distance: rental['distance'], price_per_km: car['price_per_km'])
    rent_price = days_price + distance_price

    { "id": rental['id'], "price": rent_price.to_i}
  end
end

File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({ "rentals": generate_rentals_hash }))}