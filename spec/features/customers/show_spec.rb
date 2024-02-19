require "rails_helper"

RSpec.describe "Customer Show" do

  describe 'Customer Show' do
    it ' US#1 Displays a customers name and a list of its items including its price and name of supermarket that ot belongs to' do
     supermarket_1 = Supermarket.create!(name: "Walmart", location: " 1223 DRIVE" )
     supermarket_2 = Supermarket.create!(name: "Target", location: " 1456 BLVD" )

     item_1 = supermarket_1.items.create!(name: "Gum", price: 1)
     item_2 = supermarket_2.items.create!(name: "Apple", price: 2)
     item_3 = supermarket_1.items.create!(name: "Chips", price: 3)
     item_4 = supermarket_2.items.create!(name: "Milk", price: 4)
     item_5 = supermarket_1.items.create!(name: "Cookies", price: 2)

     customer_1 = Customer.create!(name: "Bob")
     customer_2 = Customer.create!(name: "Rodrigo")


     CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
     CustomerItem.create(customer_id: customer_2.id, item_id: item_2.id)
     CustomerItem.create(customer_id: customer_2.id, item_id: item_3.id)
     CustomerItem.create(customer_id: customer_1.id, item_id: item_4.id)

     visit "/customers/#{customer_1.id}"

     expect(page).to have_content('Customer Name: Bob')
      # I see the customer's name,

      # And I see its a list of its items
      expect(page).to have_content('Customer Items:')
      expect(page).to have_content('Item name: Gum')
      expect(page).to have_content('Price: 1')
      expect(page).to have_content('Supermarket name: Walmart')

      expect(page).to have_content('Item name: Milk')
      expect(page).to have_content('Price: 4')
      expect(page).to have_content('Supermarket name: Targe')
      # including the item's name, price, and the name of the supermarket that it belongs to.
    end

    it 'US#2 Adds an item to a customer' do
      supermarket_1 = Supermarket.create!(name: "Walmart", location: " 1223 DRIVE" )
     supermarket_2 = Supermarket.create!(name: "Target", location: " 1456 BLVD" )

     item_1 = supermarket_1.items.create!(name: "Gum", price: 1)
     item_2 = supermarket_2.items.create!(name: "Apple", price: 2)
     item_3 = supermarket_1.items.create!(name: "Chips", price: 3)
     item_4 = supermarket_2.items.create!(name: "Milk", price: 4)
     item_5 = supermarket_1.items.create!(name: "Cookies", price: 2)

     customer_1 = Customer.create!(name: "Bob")
     customer_2 = Customer.create!(name: "Rodrigo")


     CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
     CustomerItem.create(customer_id: customer_2.id, item_id: item_2.id)
     CustomerItem.create(customer_id: customer_1.id, item_id: item_4.id)
      
     visit "/customers/#{customer_2.id}"

     expect(page).to have_content('Apple')
     expect(page).to_not have_content('Cookies')

     expect(page).to have_content('Add Item')

     expect(page).to have_field(:item_id)

     fill_in(:item_id, with: item_5.id)

     click_button('Submit')

     expect(current_path).to eq("/customers/#{customer_2.id}")

     expect(page).to have_content('Cookies')
    

    end


  end
end