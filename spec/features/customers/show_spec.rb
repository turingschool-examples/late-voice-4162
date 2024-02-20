require 'rails_helper'

RSpec.describe 'customer show', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @cust_1 = Customer.create!(name: "larry")

      @sup_1 = Supermarket.create!(name: "gen name", location: "mn")

      @item_1 = @sup_1.items.create(name: "item name", price: 1)
      @item_2 = @sup_1.items.create(name: "item name 2", price: 1)

      CustomerItem.create!(item_id: @item_1.id, customer_id: @cust_1.id)
      CustomerItem.create!(item_id: @item_2.id, customer_id: @cust_1.id)
    end
    
    # Story 1
    it 'displays customers and thier items' do
      # When I visit a customer show page,
      visit "/customers/#{@cust_1.id}"
      # I see the customer's name,
      expect(page).to have_content(@cust_1.name)

      within "#item-#{@item_1.id}" do
        # And I see its a list of its items 
        # including the item's name, price, and the name of the supermarket that it belongs to.
        expect(page).to have_content(@item_1.name)
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.supermarket.name)
      end

      within "#item-#{@item_2.id}" do
        # And I see its a list of its items 
        # including the item's name, price, and the name of the supermarket that it belongs to.
        expect(page).to have_content(@item_2.name)
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@item_2.supermarket.name)
      end

    end
  end
end