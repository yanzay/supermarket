class BuyNGetOneFreePricingRule < PricingRule
  def initialize(n, code)
    @n = n
    @code = code
  end

  def calculate_discount(items)
    count = 0
    price = 0
    items.each do |item|
      if item.code == @code
        count += 1
        price = item.price if price == 0
      end
    end

    if count > @n then
      return price
    else
      return 0
    end
  end
end