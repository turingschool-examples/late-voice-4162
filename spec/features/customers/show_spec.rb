require "rails_helper"

RSpec.describe "Customer#show" do
    describe 'Customer#show' do
        it "shows the customers name and a list of the items with name and price" do
            market_1 = Supermarket.create!(name: "Costco", location: "1450 ST")
            market_2 = Supermarket.create(name: "Aldi", location: "1024 DV")

            item_1 = market_1.items.create!(name: "Rice", price: 20)
            item_2 = market_2.items.create!(name: "Oreos", price: 4)

            customer_1 = Customer.create!(name: "Luis")
            customer_2 = Customer.create!(name: "Walter")

            CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
            CustomerItem.create(customer_id: customer_2.id, item_id: item_2.id)
            
            visit "/customers/#{customer_1.id}"

            expect(page).to have_content('Name of Customer: Luis')
            expect(page).to have_content('Items')
            expect(page).to have_content('Name of Item: Rice')
            expect(page).to have_content('Price of Item: 20')
            expect(page).to have_content('Name of Supermarket: Costco')
        end
    end 
end