require 'rails_helper'

RSpec.describe "Customers Show Page", type: :feature do
    it "displays a customer's name" do
        king_soopers = Supermarket.create!(name: "King Soopers", location: "Denver")

        joe = king_soopers.customers.create!(name: "Joe")
        susie = king_soopers.customers.create!(name: "Susie")

        visit "/customers/#{joe.id}"

        expect(page).to have_content("Joe")
    end

    it "displays a customer's item and its information" do
        king_soopers = Supermarket.create!(name: "King Soopers", location: "Denver")

        joe = king_soopers.customers.create!(name: "Joe")
        susie = king_soopers.customers.create!(name: "Susie")

        milk = king_soopers.items.create!(name: "milk", price: 5)
        bread = king_soopers.items.create!(name: "bread", price: 3)
        cheese = king_soopers.items.create!(name: "cheese", price: 4)

        joe.items << milk
        joe.items << bread
        joe.items << cheese

        visit "/customers/#{joe.id}"

        expect(page).to have_content("milk")
        expect(page).to have_content("$5")
        expect(page).to have_content("King Soopers")
    end
end
