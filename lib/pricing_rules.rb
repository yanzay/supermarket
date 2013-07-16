class PricingRules

  def initialize()
    @rules = []
  end

  def add_rule(rule)
    @rules.push(rule)
  end

  def calculate(items)
    discount = @rules.inject(1) do |res, rule|
      res + rule.calculate_discount(items)
    end
    sum = items.inject(0) { |res, item| res + item.price }
    (sum - discount).round(2)
  end

end
