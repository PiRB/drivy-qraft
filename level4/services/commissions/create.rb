module Commissions
  class Create
    attr_reader :rent

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
      commission_amout / 2
    end

    def assistance_fee
      100 * rent.rent_days
    end

    def commission_amout
      rent.price * 0.3
    end
  end
end