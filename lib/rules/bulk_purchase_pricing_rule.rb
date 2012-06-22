class BulkPurchasePricingRule < PricingRule

  def initialize(n, new_price, code)

    @n = n
    @new_price = new_price
    @code = code

  end

  def calculate_discount(items)

    count = items.count { |item| item.code == @code }

    if count >= @n
      old_price = ProductRepository.new.get_by_code(@code).price
      (count * (old_price - @new_price)).round(2)
    else
      0
    end

  end

end