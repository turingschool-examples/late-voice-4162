require 'rails_helper'

RSpec.describe "Customer Show Page" do
  let!(:whole_foods) { Supermarket.create!(name: "Whole Foods", location: "San Francisco") }
  let!(:safeway) { Supermarket.create!(name: "Safe Way", location: "Oakland") }

  let!(:milk) { whole_foods.items.create!(name: "milk", price: 5.99 ) }
  let!(:beef) { safeway.items.create!(name: "beef", price: 21.23 )}
  let!(:cheese) { whole_foods.items.create!(name: "cheese", price: 12.99 ) }

  let!(:tom) { Customer.create!(name: "Tom") }
  let!(:jerry) { Customer.create!(name: "Jerry") }

  let!(:customer_item_1) { CustomerItem.create!(customer_id: tom.id, item_id: milk.id) }
  let!(:customer_item_2) { CustomerItem.create!(customer_id: tom.id, item_id: beef.id) }
  let!(:customer_item_3) { CustomerItem.create!(customer_id: tom.id, item_id: cheese.id) }
  let!(:customer_item_4) { CustomerItem.create!(customer_id: jerry.id, item_id: milk.id) }

  describe "As a visitor" do
    describe "When I visit customer show page" do
      it "sees the customer's name, list of its items and the supermarket that it belongs to" do
        visit "/customers/#{tom.id}"

        expect(page).to have_content(tom.name)
        within "item-#{milk.id}"
        expect(page).to have_content(milk.name)
        expect(page).to have_content(milk.price)
        expect(page).to have_content(milk.supermarket.name)
        within "item-#{beef.id}"
        expect(page).to have_content(beef.name)
        expect(page).to have_content(beef.price)
        expect(page).to have_content(beef.supermarket.name)
        within "item-#{cheese.id}"
        expect(page).to have_content(cheese.name)
        expect(page).to have_content(cheese.price)
        expect(page).to have_content(cheese.supermarket.name)
      end

      it "sees a form to add an item to this customer, and I fill in with the id of an existing item and submit,
          then it redirects me back to the customer show page and I see the item under this customer's items" do
        visit "/customers/#{jerry.id}"

        fill_in "item_id", with: "#{cheese.id}"
        click_on "Submit"

        expect(current_path).to eq("/customers/#{jerry.id}")
        expect(page).to have_content(jerry.name)
        within "item-#{milk.id}"
        expect(page).to have_content(milk.name)
        expect(page).to have_content(milk.price)
        expect(page).to have_content(milk.supermarket.name)
        within "item-#{cheese.id}"
        expect(page).to have_content(cheese.name)
        expect(page).to have_content(cheese.price)
        expect(page).to have_content(cheese.supermarket.name)
      end
    end
  end
end
