module Actions
  class Create
    attr_reader :rent\

    def initialize(rent:)
      @rent = rent
    end

    def call
      [
        driver_action.to_h,
        owner_action,
        insurance_action,
        assistance_action,
        drivy_action
      ]
    end

    private

    def driver_action
      Action.new(
        :who => 'driver',
        :type => 'debit',
        :amount => rent.price + options_amount
      )
    end
    
    def owner_action
      Action.new(
        :who => 'owner',
        :type => 'credit',
        :amount => rent.price - rent.commission.commission_amount + owner_beneficiary_options_amount
      )
    end

    def insurance_action
      Action.new(
        :who => 'insurance',
        :type => 'credit',
        :amount => rent.commission.insurance_fee
      )
    end

    def assistance_action
      Action.new(
        :who => 'assistance',
        :type => 'credit',
        :amount => rent.commission.assistance_fee
      )
    end

    def drivy_action
      Action.new(
        :who => 'drivy',
        :type => 'credit',
        :amount => rent.commission.drivy_fee + drivy_beneficiary_options_amount
      )
    end

    def options_amount
      return 0 if rent.options.empty?

      options_prices = rent.options.map { |option| option.price_per_day * rent.rent_days }
      options_prices.sum
    end

    def owner_beneficiary_options_amount
      owner_beneficiary_options.map { |option| option.price_per_day * rent.rent_days }.sum
    end

    def drivy_beneficiary_options_amount
      drivy_beneficiary_options.map { |option| option.price_per_day * rent.rent_days }.sum
    end

    def owner_beneficiary_options
      @owner_beneficiary_options ||= rent.options.select { |option| option.beneficiary == 'owner' }
    end

    def drivy_beneficiary_options
      @drivy_beneficiary_options ||= rent.options.select { |option| option.beneficiary == 'drivy' }
    end
  end
end