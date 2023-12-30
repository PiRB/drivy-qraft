class Commission
  include Virtus.model

  attribute :insurance_fee, Integer
  attribute :assistance_fee, Integer
  attribute :drivy_fee, Integer

  def commission_hash
    {
    "insurance_fee": insurance_fee.to_i,
    "assistance_fee": assistance_fee.to_i,
    "drivy_fee": drivy_fee.to_i
  }
  end

  def commission_amount
    insurance_fee + assistance_fee + drivy_fee
  end
end