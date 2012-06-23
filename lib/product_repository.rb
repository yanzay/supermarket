require "singleton"

class ProductRepository

  include Singleton

  def initialize
    @items = [Product.new("FR1", "Fruit tea", 3.11),
              Product.new("SR1", "Strawberries", 5.00),
              Product.new("CR1", "Coffee", 11.23)]

  end

  def add_item(item)
    @items.push(item)
  end

  def get_by_code(code)
    @items.find { |item| item.code == code }
  end

end