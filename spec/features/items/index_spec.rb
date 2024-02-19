require "rails_helper"

RSpec.describe "Items Index Page", type: :feature do
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
    let!(:customer_item_3) {CustomerItem.create!(customer: customer_2, item: item_1)}

    before do
      visit "/items"
    end

    it "lists all items w/their details" do
      within "#item-#{item_1.id}" do
        expect(page).to have_content("milk")
        expect(page).to have_content("price: $4")
        expect(page).to have_content("supermarket: Walmart")

        expect(page).to_not have_content("pizza")
        expect(page).to_not have_content("cookies")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("cookies")
        expect(page).to have_content("price: $5")
        expect(page).to have_content("supermarket: Walmart")

        expect(page).to_not have_content("bread")
        expect(page).to_not have_content("pizza")
      end

      within "#item-#{item_3.id}" do
        expect(page).to have_content("pizza")
        expect(page).to have_content("price: $6")
        expect(page).to have_content("supermarket: Target")

        expect(page).to_not have_content("bread")
        expect(page).to_not have_content("cookies")
      end
    end

    it "displays number of customers that purchased item" do
      within "#item-#{item_1.id}" do
        expect(page).to have_content("item's customers: 2")
      end

      within "#item-#{item_2.id}" do
        expect(page).to have_content("item's customers: 1")
      end

      within "#item-#{item_3.id}" do
        expect(page).to have_content("item's customers: 0")
      end
    end
  end
end