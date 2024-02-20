require "rails_helper"

RSpec.describe "Index Page" do
  before(:each) do
    @customer_1 = Customer.create!(name: "Barry")
    @supermarket_1 = Supermarket.create!(name: "Crest Foods", location: "Oklahoma City")
    @item_1 = Item.create!(name: "Bacon", price: "5", supermarket_id: @supermarket_1.id )
    @item_2 = Item.create!(name: "Eggs", price: "2", supermarket_id: @supermarket_1.id )
    @item_3 = Item.create!(name: "Sausage", price: "4", supermarket_id: @supermarket_1.id )
    @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
    @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
    @customer_item_3 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)

    @customer_2 = Customer.create!(name: "Larry")
    @customer_item_4 = CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_1.id)

    visit "/items"
  end

  describe "User Story 3 - Items Index Page" do
    it "Lists all items" do
      expect(page).to have_content("Bacon")
      expect(page).to have_content("Eggs")
      expect(page).to have_content("Sausage")
    end

    it "Lists each item's price, supermarket, and count of customers" do
      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Item: Bacon")
        expect(page).to have_content("Price: $5")
        expect(page).to have_content("Supermarket: Crest Foods")
        expect(page).to have_content("Number of Customers: 2")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Item: Eggs")
        expect(page).to have_content("Price: $2")
        expect(page).to have_content("Supermarket: Crest Foods")
        expect(page).to have_content("Number of Customers: 1")
      end

      within "#item-#{@item_3.id}" do
        expect(page).to have_content("Item: Sausage")
        expect(page).to have_content("Price: $4")
        expect(page).to have_content("Supermarket: Crest Foods")
        expect(page).to have_content("Number of Customers: 1")
      end
    end
  end
end