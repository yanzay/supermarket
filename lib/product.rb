class Product
  def initialize(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  attr_reader :code, :name, :price
end