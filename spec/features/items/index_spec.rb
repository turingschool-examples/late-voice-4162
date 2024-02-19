require "rails_helper"

RSpec.describe "Item Index Page", type: :feature do
    before(:each) do 
        @supermarket1 = Supermarket.create!(name: "Corner Market", location: "123 Food St.")
        @supermarket2 = Supermarket.create!(name: "Mimi Market", location: "456 Yum St.")

        @customer1 = Customer.create!(name: "Sally Shopper")
        @customer2 = Customer.create!(name: "Molly Spender")

        @item1 = @supermarket1.items.create!(name: "Apple", price: 2)
        @item2 = @supermarket1.items.create!(name: "Banana", price: 1)
        @item3 = @supermarket2.items.create!(name: "Bread", price: 3)
        
        @customer1.items << @item1
        @customer1.items << @item2
    end
    # 3 As a visitor,
    it 'shows the list of all items with name, price, and  the name of the supermarket that it belongs to and the count of customers that bought that item' do
        # When I visit the items index page,
        visit "/items"
        # Then I see a list of all items
        # including the item's name, price, and the name of the supermarket that it belongs to
        # and the count of customers that bought that item.
        within(".item-#{@item1.id}") do
            expect(page).to have_content(@item1.name)
            expect(page).to have_content(@item1.price)
            expect(page).to have_content(@supermarket1.name)
            expect(page).to have_content("Customers Count: 1")
        end

        within(".item-#{@item2.id}") do
            expect(page).to have_content(@item2.name)
            expect(page).to have_content(@item2.price)
            expect(page).to have_content(@supermarket1.name)
            expect(page).to have_content("Customers Count: 1")
        end
        
        within(".item-#{@item3.id}") do
            expect(page).to have_content(@item3.name)
            expect(page).to have_content(@item3.price)
            expect(page).to have_content(@supermarket2.name)
            expect(page).to have_content("Customers Count: 0")
        end
    end
end