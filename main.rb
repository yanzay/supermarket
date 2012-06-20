require "./lib/product_repository"
require "./lib/product"
require "./lib/pricing_rules"
require "./lib/checkout"
require "./lib/rules/pricing_rule"
require "./lib/rules/bulk_purchase_pricing_rule"
require "./lib/rules/buy_n_get_one_free_pricing_rule"

puts "Test Data"

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
puts "-----"
print "Basket: "
co.items.each { |item| print item.code + " " }
puts "\nTotal price expected: " + co.total.to_s

co.reset

co.scan(fruit_tea)
co.scan(fruit_tea)
puts "-----"
print "Basket: "
co.items.each { |item| print item.code + " " }
puts "\nTotal price expected: " + co.total.to_s

co.reset

co.scan(strawberry)
co.scan(strawberry)
co.scan(fruit_tea)
co.scan(strawberry)
puts "-----"
print "Basket: "
co.items.each { |item| print item.code + " " }
puts "\nTotal price expected: " + co.total.to_s
