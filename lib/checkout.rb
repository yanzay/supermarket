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

  def to_s
    resp = "----\nBasket: "
    item_codes = @items.map { |item| item.code }
    resp += item_codes * " "
    resp += "\nTotal price expected: " + total.to_s
  end

  attr_reader :items

end