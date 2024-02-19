require 'rails_helper'

RSpec.describe 'Customer Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @supermarket_1 = Supermarket.create!(name: "Ralphs", location: "Over There St.")
      @customer_1 = Customer.create!(name: "Alex Long")
      @item_1 = @supermarket_1.items.create!(name: "Apple", price: 5)
      @item_2 = @supermarket_1.items.create!(name: "Banana", price: 2)
      @item_3 = @supermarket_1.items.create!(name: "Orange", price: 3)
      @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
      @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
      @customer_item_3 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)
    end

    it 'shows the customers name and list of its items' do
      visit "/customers/#{@customer_1.id}"

      expect(page).to have_content(@customer_1.name)
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
    end

    it 'shows the price of each item and the supermarket it belongs to' do
      visit "/customers/#{@customer_1.id}"

      within "#item-#{@item_1.id}" do
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@supermarket_1.name)
      end
      within "#item-#{@item_2.id}" do
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@supermarket_1.name)
      end
      within "#item-#{@item_3.id}" do
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content(@supermarket_1.name)
      end
    end
  end
end