require 'rails_helper'

RSpec.describe 'Customers Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @super_1 = Supermarket.create!(name: "Trader Joe's", location: "San Diego")

      @cust_1 = Customer.create!(name: "Paul")  
      @cust_2 = Customer.create!(name: "Jim")  

      @item_1 = @super_1.items.create!(name: "Pickles", price: 5)
      @item_2 = @super_1.items.create!(name: "Pear", price: 15)

      CustomerItem.create!(customer_id: @cust_1.id, item_id: @item_2.id)
    end
    # Story 1
    it 'displays the customers name with their items' do
      # When I visit a customer show page,
      visit "/customers/#{@cust_1.id}"
      # I see the customer's name,
      expect(page).to have_content(@cust_1.name)
      # And I see its a list of its items
      # including the item's name, price, and the name of the supermarket that it belongs to.
      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@super_1.name)
      end
    end
    # Story 2
    it "has a form to add a new item to a customer" do 
      # When I visit a customer's show page,
      visit "/customers/#{@cust_1.id}"
      # Then I see a form to add an item to this customer.
      expect(page).to have_content("Add Item")
      # When I fill in a field with the id of an existing item,
      fill_in("Item ID", with: 1)
      # And I click submit,
      click_button("Add Item")
      # Then I am redirected back to the customer's show page, 
      expect(current_path).to eq("/customers/#{@cust_1.id}")
      # And I see the item now listed under this customer's items.
      
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.supermarket)
      
    end
  end
end