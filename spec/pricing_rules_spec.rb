require "rspec"
require "../lib/pricing_rules"
require "../lib/product"
require "../lib/product_repository"
require "../lib/rules/pricing_rule"
require "../lib/rules/buy_n_get_one_free_pricing_rule"
require "../lib/rules/bulk_purchase_pricing_rule"

describe "PricingRules" do
  it "should exists" do
    PricingRules.new
  end

  it "method add_rule(rule) should add rule" do
    prs = PricingRules.new
    pr = BulkPurchasePricingRule.new(3, 4.50, "SR1")
    prs.add_rule(pr)
    prs.rules.count.should == 1
    prs.rules[0] == pr
  end

  it "should have method calculate(items)" do
    PricingRules.new.calculate([])
  end

  it "method calculate(items) should calculate price with CEO pricing rule" do
    prods = ProductRepository.new

    fruit_tea = prods.get_by_code("FR1")

    pricing_rules = PricingRules.new
    ceo_pricing_rule = BuyNGetOneFreePricingRule.new(1, fruit_tea.code)
    pricing_rules.add_rule(ceo_pricing_rule)

    sum = pricing_rules.calculate([fruit_tea])
    sum.should == fruit_tea.price

    sum = pricing_rules.calculate([fruit_tea, fruit_tea])
    sum.should == fruit_tea.price

    sum = pricing_rules.calculate([fruit_tea, fruit_tea, fruit_tea])
    sum.should == fruit_tea.price * 2
  end

  it "method calculate(items) should calculate price with COO pricing rule" do
    new_price = 4.50
    n = 3

    prods = ProductRepository.new

    strawberry = prods.get_by_code("SR1")

    pricing_rules = PricingRules.new
    coo_pricing_rule = BulkPurchasePricingRule.new(n, new_price, strawberry.code)
    pricing_rules.add_rule(coo_pricing_rule)

    items = [strawberry]
    sum = pricing_rules.calculate(items)
    sum.should == strawberry.price

    (n-1).times do items.push(strawberry) end

    sum = pricing_rules.calculate(items)
    sum.should == new_price * n
  end
end