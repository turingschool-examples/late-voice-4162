require "rails_helper"

RSpec.describe "Customer Show Page", type: :feature do
  describe "As a visitor" do
    let!(:customer_1) {Customer.create!(name: "Susan")}
    let!(:customer_2) {Customer.create!(name: "Anna")}
    let!(:supermarket_1) {Supermarket.create!(name: "Walmart", location: "E 53rd St.")}
    let!(:supermarket_2) {Supermarket.create!(name: "Target", location: "W 15th St.")}
    let!(:item_1) {supermarket_1.items.create!(name: "milk", price: 4)}
    let!(:item_2) {supermarket_1.items.create!(name: "cookies", price: 5)}
    let!(:item_3) {supermarket_2.items.create!(name: "pizza", price: 6)}
    let!(:customer_item_1) {CustomerItem.create!(customer: customer_1, item: item_1)}
    let!(:customer_item_2) {CustomerItem.create!(customer: customer_1, item: item_2)}
    let!(:customer_item_3) {CustomerItem.create!(customer: customer_1, item: item_3)}

    before do
      visit "/customers/#{customer_1.id}"
    end

    it "displays customer's name" do
      expect(page).to have_content("Susan")
      expect(page).to_not have_content("Anna")
    end

    describe "customer item list" do
      it "shows item's information" do
        within "#item-#{item_1.id}" do
          expect(page).to have_content("milk: $4 from Walmart")
        end

        within "#item-#{item_2.id}" do
          expect(page).to have_content("cookies: $5 from Walmart")
        end
        within "#item-#{item_3.id}" do
          expect(page).to have_content("pizza: $6 from Target")
        end
      end

      describe "adding item to list" do
        it "shows form to add an item" do
          expect(page).to have_content("Item ID")
        end

        it "Add Item form adds that item to the customer's show page" do
          item_5 = supermarket_2.items.create!(name: "bread", price: 3)
          fill_in :item_id, with: item_5.id
          click_on "Submit"

          expect(page).to have_content("bread: $3 from Target")
          expect(current_path).to eq("/customers/#{customer_1.id}")
        end
      end
    end
  end
end