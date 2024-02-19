require 'rails_helper'

RSpec.describe "Customer Show Page", type: :feature do
   it 'displays the customer name and I see a list of its items, including items name, price and name of the supermarket' do
      supermarket = Supermarket.create!(name: "Publix", location: "East Atlanta Village")
      customer = Customer.create!(name: "John Smith")
      item_1 = customer.items.create!(name: "Bread", price: 5, supermarket_id: supermarket.id)
      item_2 = customer.items.create!(name: "Eggs", price: 10, supermarket_id: supermarket.id)
      item_3 = customer.items.create!(name: "Milk", price: 3, supermarket_id: supermarket.id)


      visit "/customers/#{customer.id}"

      expect(page).to have_content(customer.name)

      within "#item-#{item_1.id}" do
         expect(page).to have_content(item_1.name)
         expect(page).to have_content(item_1.price)
         expect(page).to have_content(supermarket.name)
      end
      
      within "#item-#{item_2.id}" do
         expect(page).to have_content(item_2.name)
         expect(page).to have_content(item_2.price)
         expect(page).to have_content(supermarket.name)
      end

      within "#item-#{item_3.id}" do
         expect(page).to have_content(item_3.name)
         expect(page).to have_content(item_3.price)
         expect(page).to have_content(supermarket.name)
      end
   end

   it "displays a form to add item to this customer" do
      supermarket = Supermarket.create!(name: "Publix", location: "East Atlanta Village")
      customer = Customer.create!(name: "John Smith")
      item_1 = customer.items.create!(name: "Bread", price: 5, supermarket_id: supermarket.id)
      item_2 = Item.create!(name: "Eggs", price: 10, supermarket_id: supermarket.id)
      item_3 = Item.create!(name: "Milk", price: 3, supermarket_id: supermarket.id)

      visit "/customers/#{customer.id}"

      expect(page).to_not have_content("Eggs")

      expect(page).to have_content("Add Item to Cart:")
      expect(page).to have_field(:item_id)
      expect(page).to have_button("Add Item")

      fill_in(:item_id, with: item_2.id)

      click_button("Add Item")

      expect(current_path).to eq("/customers/#{customer.id}")

      expect(page).to have_content("Eggs")
   end
end