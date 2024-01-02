module Commissions
  class Create
    attr_reader :rent

    COMMISSION_VALUE = 0.3
    ROADSIDE_ASSISTANCE_AMOUNT = 100
    INSURANCE_FEE_PERCENTAGE = 0.5

    def initialize(rent:)
      @rent = rent
    end

    def call
      Commission.new(
        :insurance_fee => insurance_fee,
        :assistance_fee => assistance_fee,
        :drivy_fee => commission_amout - insurance_fee - assistance_fee
      )
    end

    private

    def insurance_fee
      commission_amout * INSURANCE_FEE_PERCENTAGE
    end

    def assistance_fee
      ROADSIDE_ASSISTANCE_AMOUNT * rent.rent_days
    end

    def commission_amout
      rent.price * COMMISSION_VALUE
    end
  end
end