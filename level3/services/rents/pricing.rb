module Rents
  class Princing
    attr_reader :rent

    DISCOUNT_AFTER_1_DAY = 0.9
    DISCOUNT_AFTER_4_DAYS = 0.7
    DISCOUNT_AFTER_10_DAYS = 0.5
    MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT = 3
    MAXIMUM_DAYS_WITH_30_PERCENT_DISCOUNT = 6

    def initialize(rent:)
      @rent = rent
    end

    def call
      days_price + distance_price
    end

    private 

    def days_price
      @rent_days ||= rent.rent_days
      price_per_day = rent.car.price_per_day

      case @rent_days
      when 5..10
        remaining_days = @rent_days - 4
        rent_days_price = price_per_day + 
                          MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_1_DAY + 
                          remaining_days * price_per_day * DISCOUNT_AFTER_4_DAYS
      when 2..4
        remaining_days = @rent_days - 1
        rent_days_price = price_per_day + remaining_days * price_per_day * DISCOUNT_AFTER_1_DAY
      when 1
        rent_days_price = price_per_day 
      else
        remaining_days = @rent_days - 10
        rent_days_price = price_per_day + 
                          MAXIMUM_DAYS_WITH_10_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_1_DAY + 
                          MAXIMUM_DAYS_WITH_30_PERCENT_DISCOUNT * price_per_day * DISCOUNT_AFTER_4_DAYS + 
                          remaining_days * price_per_day * DISCOUNT_AFTER_10_DAYS
      end
    
      rent_days_price
    end
    
    def distance_price
      rent.distance * rent.car.price_per_km
    end
  end
end