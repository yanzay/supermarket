class PricingRule

  def initialize
    throw NotImplementedError
  end

  def calculate_discount
    throw NotImplementedError
  end

end