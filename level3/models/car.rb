class Car
  include Virtus.model
  
  attribute :id, Integer
  attribute :price_per_day, Integer
  attribute :price_per_km, Integer
end