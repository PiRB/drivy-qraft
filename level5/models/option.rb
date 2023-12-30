class Option
  include Virtus.model

  attribute :id, Integer
  attribute :type, String
  attribute :price_per_day, Integer, :default => :default_price_per_day
  attribute :beneficiary, String, :default => :default_beneficiary

  def default_price_per_day
    case type
    when 'gps'
      500
    when 'baby_seat'
      200
    when 'additional_insurance'
      1000
    end
  end

  def default_beneficiary
    case type
    when 'additional_insurance'
      'drivy'
    else
      'owner'
    end
  end
end