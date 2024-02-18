require 'rails_helper'

RSpec.describe "Items Index Page" do
  let!(:whole_foods) { Supermarket.create!(name: "Whole Foods", location: "San Francisco") }

  let!(:milk) { whole_foods.items.create!(name: "milk", price: 5.99 ) }
  let!(:cheese) { whole_foods.items.create!(name: "cheese", price: 12.99 ) }

  let!(:tom) { Customer.create!(name: "Tom") }
  let!(:jerry) { Customer.create!(name: "Jerry") }

  let!(:customer_item_1) { CustomerItem.create!(customer_id: tom.id, item_id: milk.id) }
  let!(:customer_item_3) { CustomerItem.create!(customer_id: tom.id, item_id: cheese.id) }
  let!(:customer_item_4) { CustomerItem.create!(customer_id: jerry.id, item_id: milk.id) }

  describe "As a visitors" do
    describe "When I visit the items index page" do
      it "sees a list of all items including the item's name, price, and the name of the supermarket that it belongs to and the count of customers that bought that item" do
        visit "/items"

        within "item-#{milk.id}"
        expect(page).to have_content(milk.name)
        expect(page).to have_content(milk.price)
        expect(page).to have_content(milk.supermarket.name)
        expect(page).to have_content("Customers count: 2")
        within "item-#{cheese.id}"
        expect(page).to have_content(cheese.name)
        expect(page).to have_content(cheese.price)
        expect(page).to have_content(cheese.supermarket.name)
        expect(page).to have_content("Customers count: 1")
      end
    end
  end
end
