require "rails_helper"

RSpec.describe " Items Index" do

  describe 'Item Index' do
    it 'US#3 displays all item names, price and the name of the supermarket that it belongs to & the count of customers that bout that item ' do
      supermarket_1 = Supermarket.create!(name: "Walmart", location: " 1223 DRIVE" )
      supermarket_2 = Supermarket.create!(name: "Target", location: " 1456 BLVD" )

      item_1 = supermarket_1.items.create!(name: "Gum", price: 1)
      item_2 = supermarket_2.items.create!(name: "Apple", price: 2)
      item_3 = supermarket_1.items.create!(name: "Chips", price: 3)
      item_4 = supermarket_2.items.create!(name: "Milk", price: 4)
      item_5 = supermarket_1.items.create!(name: "Cookies", price: 2)

      customer_1 = Customer.create!(name: "Bob")
      customer_2 = Customer.create!(name: "Rodrigo")
      customer_3 = Customer.create!(name: "Ezequiel")


      CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
      CustomerItem.create(customer_id: customer_2.id, item_id: item_1.id)
      CustomerItem.create(customer_id: customer_3.id, item_id: item_1.id)
      CustomerItem.create(customer_id: customer_1.id, item_id: item_4.id)
      CustomerItem.create(customer_id: customer_2.id, item_id: item_4.id)
      #item1 = 3
      #item4 = 2

      visit "/items"

      expect(page).to have_content('Items:')

      within("#item-#{item_1.id}") do 
        expect(page).to have_content('Item Name: Gum')
        expect(page).to have_content('Item Price: 1')
        expect(page).to have_content('Supermarket: Walmart')
        expect(page).to have_content('Customer Purchase Count: 3')
      end

      within("#item-#{item_4.id}") do 
      expect(page).to have_content('Item Name: Milk')
      expect(page).to have_content('Item Price: 4')
      expect(page).to have_content('Supermarket: Target')
      expect(page).to have_content('Customer Purchase Count: 2')
    end
    end
  end
end