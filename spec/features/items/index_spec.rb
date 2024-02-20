require 'rails_helper'

RSpec.describe 'item index', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @cust_1 = Customer.create!(name: "larry")

      @sup_1 = Supermarket.create!(name: "gen name", location: "mn")

      @item_1 = @sup_1.items.create(name: "item name 1", price: 1)
      @item_2 = @sup_1.items.create(name: "item name 2", price: 1)
      @item_3 = @sup_1.items.create(name: "item name 3", price: 1)

      CustomerItem.create!(item_id: @item_1.id, customer_id: @cust_1.id)
      CustomerItem.create!(item_id: @item_2.id, customer_id: @cust_1.id)
    end

    # Story 3
    it 'displays item attributes and a count of customers who ahve purchased it' do
      # When I visit the items index page,
      visit '/items'
      
      # Then I see a list of all items
      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.name)
        # including the item's name, price, and the name of the supermarket that it belongs to
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@item_1.supermarket.name)
        # and the count of customers that bought that item.
        expect(page).to have_content("Purchase Count: 1")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.name)
        # including the item's name, price, and the name of the supermarket that it belongs to
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@item_2.supermarket.name)
        # and the count of customers that bought that item.
        expect(page).to have_content("Purchase Count: 1")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.name)
        # including the item's name, price, and the name of the supermarket that it belongs to
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content(@item_3.supermarket.name)
        # and the count of customers that bought that item.
        expect(page).to have_content("Purchase Count: 0")
      end
    end
  end
end