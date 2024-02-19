require 'rails_helper'

RSpec.describe "Customers Show Page" do

    it "displays a customer's name" do
        joe = Customer.create("Joe")
        mary = Customer.create("Mary")
        susie = Customer.create("Susie")

        milk = Item.create("milk", 5, supermarket: king_soopers)
        bread = Item.create("bread", 3, supermarket: king_soopers)
        cheese = Item.create("cheese", 4, supermarket: king_soopers)

        king_soopers = Supermarket.create("King Soopers", "Denver")

        visit "/customers/#{joe.id}"

        expect(page).to have_content("Joe")
    end

    it "displays a customer's item and with its informatiom" do
        joe = Customer.create("Joe")
        mary = Customer.create("Mary")
        susie = Customer.create("Susie")

        milk = Item.create("milk", 5, supermarket: king_soopers)
        bread = Item.create("bread", 3, supermarket: king_soopers)
        cheese = Item.create("cheese", 4, supermarket: king_soopers)

        king_soopers = Supermarket.create("King Soopers", "Denver")


    end
end