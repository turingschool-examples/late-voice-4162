# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

@supermarket_1 = Supermarket.create!(name: "Ralphs", location: "Over There St.")
@customer_1 = Customer.create!(name: "Alex Long")
@item_1 = @supermarket_1.items.create!(name: "Apple", price: 5)
@item_2 = @supermarket_1.items.create!(name: "Banana", price: 2)
@item_3 = @supermarket_1.items.create!(name: "Orange", price: 3)
@item_4 = @supermarket_1.items.create!(name: "Onion", price: 1)
@item_5 = @supermarket_1.items.create!(name: "Bell Pepper", price: 4)
@customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
@customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
@customer_item_3 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)