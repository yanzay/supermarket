class BulkPurchasePricingRule < PricingRule
  def initialize(n, new_price, code)
    @n = n
    @new_price = new_price
    @code = code
  end

  def calculate_discount(items)
    count = 0
    items.each do |item|
      count += 1 if item.code == @code
    end

    if count >= @n
      old_price = ProductRepository.new.get_by_code(@code).price
      return (count * (old_price - @new_price)).round(2)
    else
      return 0
    end
  end
end