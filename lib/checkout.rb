class Checkout
  def initialize(pricing_rules)
    @pricing_rules = pricing_rules
    @items = []
  end

  def scan(item)
    @items.push(item)
  end

  def total
    @pricing_rules.calculate(@items)
  end

  def reset
    @items = []
  end

  attr_reader :items

end