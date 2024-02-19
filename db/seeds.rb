# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


@customer = Customer.create!(name: "Sally")
@supermarket = Supermarket.create!(name: "Corner Market", location: "123 Food St")
@item1 = @supermarket.items.create!(name: "banana", price: 1)
@item2 = @supermarket.items.create!(name: "apple", price: 2)
@customeritem = CustomerItem.create!(customer_id: @customer.id, item_id: @item1.id)