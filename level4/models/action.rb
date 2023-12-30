class Action
  include Virtus.model

  attribute :who, String
  attribute :type, String
  attribute :amount, Integer

  def action_hash
    {
      "who": who,
      "type": type,
      "amount": amount
    }
  end
end