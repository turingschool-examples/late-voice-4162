require 'rails_helper'

RSpec.describe "Items index page", type: :feature do

  describe "User story 3" do
        it "displays customer name and their items along with item attributes" do

            alain = Customer.create!(name: "Alain King")
            odell = Customer.create!(name: "Odell Mac")
            wilson = Customer.create!(name: "Wilson Lora")
            janay = Customer.create!(name: "Janay Tate")

            walmart = Supermarket.create!(name: "Walmart", location: "900 Walmart Drive")
            target = Supermarket.create!(name: "Target", location: "800 Target Drive")

            guac = walmart.items.create!(name: "Guacamole", price: 5)
            mango = walmart.items.create!(name: "Mango", price: 2)
            popcorn = target.items.create!(name: "Popcorn", price: 3)
            almonds = target.items.create!(name: "Almonds", price: 6)

            alain.items << [mango, almonds]
            odell.items << [guac, popcorn]
            wilson.items << [mango, almonds, guac, popcorn]
            janay.items << [almonds, mango, popcorn]
            # As a visitor,
            # When I visit the items index page,
            visit "/items"
            # Then I see a list of all items
            expect(page).to have_content("All Items")
            # And I see its a list of its items 
            # including the item's name, price, and the name of the supermarket that it belongs to
            # and the count of customers that bought that item.
            within("#item-#{mango.id}")do
                expect(page).to have_content("Mango")
                expect(page).to have_content("Price: $2")
                expect(page).to have_content("Supermarket: Walmart")
                expect(page).to have_content("Number of Customers Bought: 3")
            end

            within("#item-#{almonds.id}")do
                expect(page).to have_content("Almonds")
                expect(page).to have_content("Price: $6")
                expect(page).to have_content("Supermarket: Target")
                expect(page).to have_content("Number of Customers Bought: 3")
            end
            within("#item-#{popcorn.id}")do
                expect(page).to have_content("Popcorn")
                expect(page).to have_content("Price: $3")
                expect(page).to have_content("Supermarket: Target")
                expect(page).to have_content("Number of Customers Bought: 3")
            end
            within("#item-#{guac.id}")do
                expect(page).to have_content("Guacamole")
                expect(page).to have_content("Price: $5")
                expect(page).to have_content("Supermarket: Walmart")
                expect(page).to have_content("Number of Customers Bought: 2")
            end
        end
    end
end