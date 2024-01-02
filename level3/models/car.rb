class Car
  include Virtus.model
  
  attribute :id, Integer
  attribute :price_per_day, Integer
  attribute :price_per_km, Integer

  def initialize(car:)
    self.id = car['id']
    self.price_per_day = car['price_per_day']
    self.price_per_km = car['price_per_km']
  end
end