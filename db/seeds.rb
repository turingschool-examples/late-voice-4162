# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
@super_1 = Supermarket.create!(name: "Trader Joe's", location: "San Diego")

      @cust_1 = Customer.create!(name: "Paul")  
      @cust_2 = Customer.create!(name: "Jim")  

      @item_1 = @super_1.items.create!(name: "Pickles", price: 5)
      @item_2 = @super_1.items.create!(name: "Pear", price: 15)

      CustomerItem.create!(customer_id: @cust_1.id, item_id: @item_2.id)