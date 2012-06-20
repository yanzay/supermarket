require "rspec"
require "../lib/product"

describe "product" do
  it "should exists" do
    pr = Product.new("FR1", "Fruit tea", 3.11)
  end
end