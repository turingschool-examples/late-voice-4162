require 'rails_helper'

RSpec.describe 'supermarket show', type: :feature do
  describe 'As a visitor' do
    before(:each) do
      @cust_1 = Customer.create!(name: "larry")
      @cust_2 = Customer.create!(name: "Logan")
      @cust_3 = Customer.create!(name: "Jessie")

      @sup_1 = Supermarket.create!(name: "gen name", location: "mn")

      @item_1 = @sup_1.items.create(name: "item name 1", price: 1)
      @item_2 = @sup_1.items.create(name: "item name 2", price: 1)
      @item_3 = @sup_1.items.create(name: "item name 3", price: 1)

      CustomerItem.create!(item_id: @item_1.id, customer_id: @cust_1.id)
      CustomerItem.create!(item_id: @item_2.id, customer_id: @cust_2.id)
    end

    # Extension
    it 'displays the customers who have shopped at this market' do
      # When I visit a supermarket's show page,
      visit "/supermarkets/#{@sup_1.id}"
      # Then I see a unique list of all customers that have shopped at the supermarket.
      expect(page).to have_content(@cust_1.name)
      expect(page).to have_content(@cust_2.name)
      expect(page).to_not have_content(@cust_3.name)
    end
  end
end