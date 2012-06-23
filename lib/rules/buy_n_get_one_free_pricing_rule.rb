class BuyNGetOneFreePricingRule < PricingRule

  def initialize(n, code)
    @n = n
    @code = code
  end

  def calculate_discount(items)
    count = items.count { |item| item.code == @code }
    price = ProductRepository.instance.get_by_code(@code).price
    count > @n ? price : 0
  end

end