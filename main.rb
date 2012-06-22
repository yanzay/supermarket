require_relative "./lib/product_repository"
require_relative "./lib/product"
require_relative "./lib/pricing_rules"
require_relative "./lib/checkout"
require_relative "./lib/rules/pricing_rule"
require_relative "./lib/rules/bulk_purchase_pricing_rule"
require_relative "./lib/rules/buy_n_get_one_free_pricing_rule"

puts "Test Data"

prods = ProductRepository.new

fruit_tea = prods.get_by_code("FR1")
strawberry = prods.get_by_code("SR1")
coffee = prods.get_by_code("CR1")

ceo_pricing_rule = BuyNGetOneFreePricingRule.new(1, fruit_tea.code)
coo_pricing_rule = BulkPurchasePricingRule.new(3, 4.50, strawberry.code)

pricing_rules = PricingRules.new
pricing_rules.add_rule(ceo_pricing_rule)
pricing_rules.add_rule(coo_pricing_rule)

co = Checkout.new(pricing_rules)

co.scan(fruit_tea)
co.scan(strawberry)
co.scan(fruit_tea)
co.scan(coffee)
puts co

co.reset

co.scan(fruit_tea)
co.scan(fruit_tea)
puts co

co.reset

co.scan(strawberry)
co.scan(strawberry)
co.scan(fruit_tea)
co.scan(strawberry)
puts co
