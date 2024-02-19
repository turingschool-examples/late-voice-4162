require 'rails_helper'

RSpec.describe "Customer Show Page", type: :feature do
   it 'displays the customer name and I see a list of its items, including items name, price and name of the supermarket' do
      supermarket = Supermarket.create!(name: "Publix", location: "East Atlanta Village")
      customer = Customer.create!(name: "John Smith")
      item_1 = customer.items.create!(name: "Bread", price: 5, supermarket_id: supermarket.id)
      item_2 = customer.items.create!(name: "Eggs", price: 10, supermarket_id: supermarket.id)
      item_3 = customer.items.create!(name: "Milk", price: 3, supermarket_id: supermarket.id)


      visit "customers/#{customer.id}"

      expect(page).to have_content(customer.name)
      expect(page).to have_content(item_1.name)
      expect(page).to have_content(item_1.price)
      expect(page).to have_content(supermarket.name)
      expect(page).to have_content(item_2.name)
      expect(page).to have_content(item_2.price)
      expect(page).to have_content(supermarket.name)
      expect(page).to have_content(item_3.name)
      expect(page).to have_content(item_3.price)
      expect(page).to have_content(supermarket.name)
   end
end