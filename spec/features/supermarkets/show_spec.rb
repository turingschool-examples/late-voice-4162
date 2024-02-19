require 'rails_helper'

RSpec.describe 'Supermarkets Show Page', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @supermarket_1 = Supermarket.create!(name: "Ralphs", location: "Over There St.")
      @supermarket_2 = Supermarket.create!(name: "Dougs", location: "Over Here St.")
      @customer_1 = Customer.create!(name: "Alex Long")
      @customer_2 = Customer.create!(name: "Alex Short")
      @customer_3 = Customer.create!(name: "Alex Medium")
      @item_1 = @supermarket_1.items.create!(name: "Apple", price: 5)
      @item_2 = @supermarket_1.items.create!(name: "Banana", price: 2)
      @item_3 = @supermarket_1.items.create!(name: "Orange", price: 3)
      @item_4 = @supermarket_2.items.create!(name: "Onion", price: 1)
      @item_5 = @supermarket_2.items.create!(name: "Bell Pepper", price: 4)
      @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
      @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
      @customer_item_3 = CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_3.id)
      @customer_item_4 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)
      @customer_item_5 = CustomerItem.create!(customer_id: @customer_3.id, item_id: @item_3.id)
      @customer_item_6 = CustomerItem.create!(customer_id: @customer_3.id, item_id: @item_4.id)
    end

    it 'sees a unique list of all customers who have purchased something that the store' do
      visit "/supermarkets/#{@supermarket_1}"

      expect(page).to have_content("Customers")

      within "#customers" do
        expect(page).to have_content(@customer_1.name)
        expect(page).to have_content(@customer_2.name)
        expect(page).to have_content(@customer_3.name)
        expect(page).not_to have_content(@customer_4.name)
        expect(page).not_to have_content(@customer_5.name)
      end

      visit "/supermarkets/#{@supermarket_2}"

      within "#customers" do
        expect(page).not_to have_content(@customer_1.name)
        expect(page).not_to have_content(@customer_2.name)
        expect(page).not_to have_content(@customer_3.name)
        expect(page).to have_content(@customer_4.name)
        expect(page).to have_content(@customer_5.name)
      end
    end
  end
end