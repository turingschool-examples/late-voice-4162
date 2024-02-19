require 'rails_helper'

RSpec.describe 'Items Index Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @supermarket_1 = Supermarket.create!(name: "Ralphs", location: "Over There St.")
      @supermarket_2 = Supermarket.create!(name: "Dougs", location: "Over Here St.")
      @customer_1 = Customer.create!(name: "Alex Long")
      @item_1 = @supermarket_1.items.create!(name: "Apple", price: 5)
      @item_2 = @supermarket_1.items.create!(name: "Banana", price: 2)
      @item_3 = @supermarket_1.items.create!(name: "Orange", price: 3)
      @item_4 = @supermarket_2.items.create!(name: "Onion", price: 1)
      @item_5 = @supermarket_2.items.create!(name: "Bell Pepper", price: 4)
      @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
      @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
      @customer_item_3 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)

      visit "/items"
    end

    it 'shows all items' do
      expect(page).to have_content(@item_1.name)
      expect(page).to have_content(@item_2.name)
      expect(page).to have_content(@item_3.name)
      expect(page).to have_content(@item_4.name)
      expect(page).to have_content(@item_5.name)
    end

    it 'shows all items prices and the supermarket they belong to' do
      within "#item -#{@item_1.id}" do
        expect(page).to have_content(@item_1.price)
        expect(page).to have_content(@supermarket_1.name)
      end
      within "#item -#{@item_2.id}" do
        expect(page).to have_content(@item_2.price)
        expect(page).to have_content(@supermarket_1.name)
      end
      within "#item -#{@item_3.id}" do
        expect(page).to have_content(@item_3.price)
        expect(page).to have_content(@supermarket_1.name)
      end
      within "#item -#{@item_4.id}" do
        expect(page).to have_content(@item_4.price)
        expect(page).to have_content(@supermarket_2.name)
      end
      within "#item -#{@item_5.id}" do
        expect(page).to have_content(@item_5.price)
        expect(page).to have_content(@supermarket_2.name)
      end
    end
  end
end