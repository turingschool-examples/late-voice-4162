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

  describe 'User story 2' do
    it 'displays a form to add item by item id' do
        alain = Customer.create!(name: "Alain King")

        walmart = Supermarket.create!(name: "Walmart", location: "900 Walmart Drive")
        target = Supermarket.create!(name: "Target", location: "800 Target Drive")

        guac = walmart.items.create!(name: "Guacamole", price: 5)
        mango = walmart.items.create!(name: "Mango", price: 2)
        popcorn = target.items.create!(name: "Popcorn", price: 3)
        almonds = target.items.create!(name: "Almonds", price: 6)

        alain.items << [mango, almonds]

        # As a visitor,
        # When I visit a customer's show page,
        visit "/customers/#{alain.id}"
        # Then I see a form to add an item to this customer.
        # When I fill in a field with the id of an existing item,
        expect(page).to_not have_content("Popcorn")
        expect(page).to have_field("item_id")
        expect(page).to have_button("Add Item")

        fill_in("item_id", with: popcorn.id)
        # And I click submit,
        click_on "Add Item"
        # Then I am redirected back to the customer's show page,
        expect(current_path).to eq("/customers/#{alain.id}")
        # And I see the item now listed under this customer's items.
        expect(page).to have_content("Popcorn")
        # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)
    end
  end
end