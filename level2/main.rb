# frozen_string_literal: true
require 'json'
require 'date'
require '../lib/read_data'
require '../lib/rent_days'

OUTPUT_FILE_PATH = './data/output.json'
DISCOUNT_AFTER_1_DAY = 0.9
DISCOUNT_AFTER_4_DAYS = 0.7
DISCOUNT_AFTER_10_DAYS = 0.5
MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT = 3
MAXIMUM_DAYS_WITH_30_PERCENT_DISCOUNT = 6

def days_rent_price(rent:, price_per_day:)
  rent_days = compute_rent_days(rent)
  case rent_days
  when 5..10
    remaining_days = rent_days - 4
    rent_days_price = price_per_day + 
                      MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_1_DAY + 
                      remaining_days * price_per_day * DISCOUNT_AFTER_4_DAYS
  when 2..4
    remaining_days = rent_days - 1
    rent_days_price = price_per_day + remaining_days * price_per_day * DISCOUNT_AFTER_1_DAY
  when 1
    rent_days_price = price_per_day 
  else
    remaining_days = rent_days - 10
    rent_days_price = price_per_day + 
                      MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_1_DAY + 
                      MAXIMUM_DAYS_WITH_30_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_4_DAYS + 
                      remaining_days * price_per_day * DISCOUNT_AFTER_10_DAYS
  end

  rent_days_price
end

def distance_rent_price(distance:, price_per_km:)
  distance * price_per_km
end

def compute_rent_pricing(car:, rent:)
  days_price = days_rent_price(rent:, price_per_day: car['price_per_day'])
  distance_price = distance_rent_price(distance: rent['distance'], price_per_km: car['price_per_km'])

  days_price + distance_price
end

def generate_rentals_hash
  data_hash = read_data

  data_hash['rentals'].map do |rent|
    car = data_hash['cars'].find { |car| car['id'] == rent['car_id'] }

    rent_price = compute_rent_pricing(car:, rent:)

    { "id": rent['id'], "price": rent_price.to_i }
  end
end

File.open(OUTPUT_FILE_PATH, 'w') {|file| file.write(JSON.pretty_generate({ "rentals": generate_rentals_hash }))}