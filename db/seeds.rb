# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@cust_1 = Customer.create!(name: "larry")

@sup_1 = Supermarket.create!(name: "gen name", location: "mn")

@item_1 = @sup_1.items.create(name: "item name 1", price: 1)
@item_2 = @sup_1.items.create(name: "item name 2", price: 1)
@item_3 = @sup_1.items.create(name: "item name 3", price: 1)

CustomerItem.create!(item_id: @item_1.id, customer_id: @cust_1.id)
CustomerItem.create!(item_id: @item_2.id, customer_id: @cust_1.id)