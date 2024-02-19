require 'rails_helper'

RSpec.describe "Customer Show" do
# Story 1
    it 'shows the customer name, purchased item with name, price, and name of supermarket item belongs to' do
        whole_foods = Supermarket.create!(name: "Whole Foods", location: "1 First St")
        nico = Customer.create!(name: "Nico Shopper")
        jenna = Customer.create!(name: "Jenna Shopper")
        banana = whole_foods.items.create!(name: "Banana", price: 1)
        apple = whole_foods.items.create!(name: "Apple", price: 2)
        chocolate = whole_foods.items.create!(name: "Chocolate", price: 3)
        nico_item_1 = CustomerItem.create!(customer: nico, item: banana)
        nico_item_2 = CustomerItem.create!(customer: nico, item: apple)
        jenna_item_1 = CustomerItem.create!(customer: jenna, item: chocolate)
    
        safeway = Supermarket.create!(name: "Safeway", location: "2 Second St")
        wolf = Customer.create!(name: "Wolf Shopper")
        sean = Customer.create!(name: "Sean Shopper")
        orange_bag = whole_foods.items.create!(name: "Orange Bag", price: 4)
        juice = whole_foods.items.create!(name: "Juice", price: 5)
        eggs = whole_foods.items.create!(name: "Eggs", price: 6)
    
        # When I visit a customer show page,
        visit "/customer/#{nico.id}"
        # I see the customer's name,
        expect(page).to have_content("Nico Shopper")
        expect(page).to_not have_content("Jenna Shopper")
        # And I see its a list of its items
        # including the item's name, price, and the name of the supermarket that it belongs to.
        expect(page).to have_content("Purchased Items:")
        expect(page).to have_content("Banana - 1 - Whole Foods")
        expect(page).to have_content("Apple - 2 - Whole Foods")
        expect(page).to_not have_content("Chocolate")
    end
end