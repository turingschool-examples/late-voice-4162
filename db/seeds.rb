# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
joe = Customer.create("Joe")
mary = Customer.create("Mary")
susie = Customer.create("Susie")

milk = Item.create("milk", 5, supermarket: king_soopers)
bread = Item.create("bread", 3, supermarket: king_soopers)
cheese = Item.create("cheese", 4, supermarket: king_soopers)

king_soopers = Supermarket.create("King Soopers", "Denver")