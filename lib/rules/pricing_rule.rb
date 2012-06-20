class PricingRule
  def initialize
    throw NotImplementedError
  end

  def calculate_discount(items)
    throw NotImplementedError
  end
end