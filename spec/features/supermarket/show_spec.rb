require "rails_helper"

RSpec.describe "supermarket Show page" do
   it 'displays a unique list of all customers that have shopped at the supermarket' do
      publix = Supermarket.create!(name: "Publix", location: "East Atlanta Village")

      john = Customer.create!(name: "John Smith")
      peter = Customer.create!(name: "Peter Jones")
      lucy = Customer.create!(name: "Lucy Veron")

      bread = Item.create!(name: "Bread", price: 5, supermarket_id: publix.id)

      lucy_item = CustomerItem.create!(customer_id: lucy.id, item_id: bread.id)
      peter_item = CustomerItem.create!(customer_id: peter.id, item_id: bread.id)
      john_item = CustomerItem.create!(customer_id: john.id, item_id: bread.id)

      visit "/supermarkets/#{publix.id}"

      expect(page).to have_content("Publix")
      expect(page).to have_content("Recent Customers:")
      expect(page).to have_content("John Smith")
      expect(page).to have_content("Peter Jones")
      expect(page).to have_content("Lucy Veron")
   end
end