require 'rails_helper'

RSpec.describe "Customer show page", type: :feature do

  describe "User story 1" do
    it "displays customer name and their items along with item attributes" do
        alain = Customer.create!(name: "Alain King")

        walmart = Supermarket.create!(name: "Walmart", location: "900 Walmart Drive")
        target = Supermarket.create!(name: "Target", location: "800 Target Drive")

        guac = walmart.items.create!(name: "Guacamole", price: 5)
        mango = walmart.items.create!(name: "Mango", price: 2)
        popcorn = target.items.create!(name: "Popcorn", price: 3)
        almonds = target.items.create!(name: "Almonds", price: 6)

        alain.items << [mango, almonds]
        # As a visitor, 
        # When I visit a customer show page,
        visit "/customers/#{alain.id}"
        # I see the customer's name,
        expect(page).to have_content("Alain King's Items")
        # And I see its a list of its items        
        within("#item-#{mango.id}")do
            expect(page).to have_content("Mango")
            expect(page).to have_content("Price: $2")
            expect(page).to have_content("Supermarket: Walmart")
        end

        within("#item-#{almonds.id}")do
            expect(page).to have_content("Almonds")
            expect(page).to have_content("Price: $6")
            expect(page).to have_content("Supermarket: Target")
        end
        # including the item's name, price, and the name of the supermarket that it belongs to.
    end
  end
end