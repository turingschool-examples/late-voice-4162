require "rails_helper"

RSpec.describe "Customer Show Page", type: :feature do
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

    # 1 As a visitor, 
    it 'shows customer name and items' do

        # When I visit a customer show page,
        visit "/customers/#{@customer1.id}"
        # I see the customer's name,
        expect(page).to have_content(@customer1.name)
        # And I see its a list of its items
        # including the item's name, price, and the name of the supermarket that it belongs to.
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.price)
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.price)
        expect(page).to have_content(@supermarket1.name)
    end

    # 2 As a visitor,
    it 'shows a form to add an item, allows to fill in a field with the id of an existing item, when clicking submit, it redirected back to the customers show page
    and shows the item now listed under this customers items' do 

        # When I visit a customer's show page,
        visit "/customers/#{@customer1.id}"
        # Then I see a form to add an item to this customer.
        expect(page).to have_field("item_id")
        # When I fill in a field with the id of an existing item,
        fill_in "item_id", with: @item1.id

        # And I click submit,
        click_on "Submit"

        # Then I am redirected back to the customer's show page, 
        expect(current_path).to eq("/customers/#{@customer1.id}")

        # And I see the item now listed under this customer's items.
        # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.price)
        expect(page).to have_content(@supermarket1.name)
    end
end
