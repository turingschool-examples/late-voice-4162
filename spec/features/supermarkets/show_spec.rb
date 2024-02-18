require 'rails_helper'

RSpec.describe "Supermarket Show Page" do
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
    describe "When I visit a supermarket's show page" do
      it "sees a unique list of all customers that have shopped at the supermarket" do
        visit "/supermarkets/#{whole_foods.id}"

        within "supermarket-#{whole_foods.id}"
        expect(page).to have_content(tom.name, count: 1)
        expect(page).to have_content(jerry.name)
      end
    end
  end
end
