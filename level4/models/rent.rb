class Rent
  include Virtus.model

  attribute :id, Integer
  attribute :price, Integer
  attribute :commission, Commission
  attribute :car, Car
  attribute :start_date, String
  attribute :end_date, String
  attribute :distance, Integer
  attribute :actions, Array[Action]

  def compute_pricing
    return 0 if rent_days == 0
    @rent_days ||= rent_days
    case @rent_days
    when 5..10
      rent_price = car.price_per_day + 3 * car.price_per_day * 0.9 + (@rent_days - 4) * car.price_per_day * 0.7
    when 2..4
      rent_price = car.price_per_day + (@rent_days - 1) * car.price_per_day * 0.9
    when 1
      rent_price = car.price_per_day 
    else
      rent_price = car.price_per_day + 3 * car.price_per_day * 0.9 + 6 * car.price_per_day * 0.7 + (@rent_days - 10) * car.price_per_day * 0.5
    end
  
    rent_price += distance * car.price_per_km.to_i
  end

  def rent_days
    return -1 if Date.parse(start_date) > Date.parse(end_date)

    return (Date.parse(end_date) -  Date.parse(start_date) + 1).to_i
  end
end