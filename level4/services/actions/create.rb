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
        :amount => rent.price
      )
    end
    
    def owner_action
      Action.new(
        :who => 'owner',
        :type => 'credit',
        :amount => rent.price - rent.commission.commission_amount 
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
        :amount => rent.commission.drivy_fee
      )
    end
  end
end