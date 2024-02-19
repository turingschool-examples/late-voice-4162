require "rails_helper"

RSpec.describe "Items Index page" do 
   it 'shows all the items including, name, price, supermarket and count of customers that bought it' do
      publix = Supermarket.create!(name: "Publix", location: "East Atlanta Village")
      whole_foods = Supermarket.create!(name: "Whole Foods", location: "Decatur")

      john = Customer.create!(name: "John Smith")
      peter = Customer.create!(name: "Peter Jones")
      lucy = Customer.create!(name: "Lucy Veron")

      item_1 = Item.create!(name: "Bread", price: 5, supermarket_id: publix.id)
      item_2 = Item.create!(name: "Bacon", price: 7, supermarket_id: publix.id)
      item_3 = Item.create!(name: "Eggs", price: 10, supermarket_id: publix.id)
      item_4 = Item.create!(name: "Milk", price: 3, supermarket_id: whole_foods.id)

      lucy_item_1 = CustomerItem.create!(customer_id: lucy.id, item_id: item_1.id)
      lucy_item_2 = CustomerItem.create!(customer_id: lucy.id, item_id: item_2.id)
      lucy_item_3 = CustomerItem.create!(customer_id: lucy.id, item_id: item_3.id)

      peter_item_1 = CustomerItem.create!(customer_id: peter.id, item_id: item_1.id)
      peter_item_2 = CustomerItem.create!(customer_id: peter.id, item_id: item_2.id)
      peter_item_3 = CustomerItem.create!(customer_id: peter.id, item_id: item_3.id)

      john_item_1 = CustomerItem.create!(customer_id: john.id, item_id: item_4.id)

      visit "/items"

      within "#item-#{item_1.id}" do
         expect(page).to have_content("Bread")
         expect(page).to have_content("Price: $5.00")
         expect(page).to have_content("Supermarket: Publix")
         expect(page).to have_content("Total times sold: 2")
      end

      within "#item-#{item_2.id}" do
         expect(page).to have_content("Bacon")
         expect(page).to have_content("Price: $7.00")
         expect(page).to have_content("Supermarket: Publix")
         expect(page).to have_content("Total times sold: 2")
      end

      within "#item-#{item_3.id}" do
         expect(page).to have_content("Eggs")
         expect(page).to have_content("Price: $10.00")
         expect(page).to have_content("Supermarket: Publix")
         expect(page).to have_content("Total times sold: 2")
      end

      within "#item-#{item_4.id}" do
         expect(page).to have_content("Milk")
         expect(page).to have_content("Price: $3.00")
         expect(page).to have_content("Supermarket: Whole Foods")
         expect(page).to have_content("Total times sold: 1")
      end
   end
end