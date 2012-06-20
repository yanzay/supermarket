require "rspec"
require "../lib/checkout"
require "../lib/pricing_rules"
require "../lib/product"
require "../lib/product_repository"
require "../lib/rules/pricing_rule"
require "../lib/rules/buy_n_get_one_free_pricing_rule"
require "../lib/rules/bulk_purchase_pricing_rule"

describe "checkout" do
  it "should exists" do
    pricing_rules = PricingRules.new()
    Checkout.new(pricing_rules)
  end

  it "should have method scan(item)" do
    pricing_rules = PricingRules.new()
    item = Product.new("FR1", "Fruit tea", 3.11)
    Checkout.new(pricing_rules).scan(item)
  end

  it "should have property items" do
    pricing_rules = PricingRules.new()
    item = Product.new("FR1", "Fruit tea", 3.11)
    Checkout.new(pricing_rules).items
  end

  it "scan(item) method should adding new item" do
    pricing_rules = PricingRules.new
    item = Product.new("FR1", "Fruit tea", 3.11)
    co = Checkout.new(pricing_rules)
    co.scan(item)
    co.items.count.should == 1
    co.items[0].should == item
  end

  it "should have property total" do
    pricing_rules = PricingRules.new
    Checkout.new(pricing_rules).total
  end

  it "total property should return right answers with ceo and coo pricing rules" do
    prods = ProductRepository.new
    fruit_tea = prods.get_by_code("FR1")
    strawberry = prods.get_by_code("SR1")
    coffee = prods.get_by_code("CR1")

    pricing_rules = PricingRules.new
    ceo_pricing_rule = BuyNGetOneFreePricingRule.new(1, fruit_tea.code)
    coo_pricing_rule = BulkPurchasePricingRule.new(3, 4.50, strawberry.code)
    pricing_rules.add_rule(ceo_pricing_rule)
    pricing_rules.add_rule(coo_pricing_rule)

    co = Checkout.new(pricing_rules)
    co.scan(fruit_tea)
    co.scan(strawberry)
    co.scan(fruit_tea)
    co.scan(coffee)
    co.total.should == 19.34

    co.reset

    co.scan(fruit_tea)
    co.scan(fruit_tea)
    co.total.should == 3.11

    co.reset

    co.scan(strawberry)
    co.scan(strawberry)
    co.scan(fruit_tea)
    co.scan(strawberry)
    co.total.should == 16.61
  end

end