class Rent
  include Virtus.model

  attribute :id, Integer
  attribute :price, Integer
  attribute :commission, Commission
  attribute :car, Car
  attribute :start_date, String
  attribute :end_date, String
  attribute :distance, Integer

  def initialize(rent:)
    self.id = rent['id']
    self.start_date = rent['start_date']
    self.end_date = rent['end_date']
    self.distance = rent['distance']
  end

  def rent_days
    return (Date.parse(end_date) -  Date.parse(start_date) + 1).to_i
  end
end