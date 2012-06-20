class PricingRules
  def initialize()
    @rules = []
  end

  def add_rule(rule)
    @rules.push(rule)
  end

  def calculate(items)
    discount = 0
    sum = 0
    @rules.each { |rule| discount += rule.calculate_discount(items) }
    items.each { |item| sum += item.price }
    (sum - discount).round(2)
  end

  attr_reader :rules
end