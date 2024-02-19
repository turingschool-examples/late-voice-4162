require "rails_helper"

RSpec.describe "Index Page" do
  before(:each) do
    @betty = Customer.create!(name: "Betty")
    @frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    @bananas = Item.create!(name: "Bananas", price: "1", supermarket_id: @frys.id )
    @apples = Item.create!(name: "Apples", price: "3", supermarket_id: @frys.id)
    @carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: @frys.id)
    @bettys_bananas = CustomerItem.create!(customer_id: @betty.id, item_id: @bananas.id)
    @bettys_apples = CustomerItem.create!(customer_id: @betty.id, item_id: @apples.id)
    @bettys_carrots = CustomerItem.create!(customer_id: @betty.id, item_id: @carrots.id)

    @jake = Customer.create!(name: "Jake")
    @jakes_carrots = CustomerItem.create!(customer_id: @jake.id, item_id: @carrots.id)

    visit items_path
  end

  describe "User Story 3" do
    it "displays a list of all items" do
      expect(page).to have_content("Bananas")
      expect(page).to have_content("Apples")
      expect(page).to have_content("Carrots")
    end

    it "displays every item's price, supermarket, and count of customers" do
      within "#item-#{@bananas.id}" do
        expect(page).to have_content("Item: Bananas")
        expect(page).to have_content("Price: $1")
        expect(page).to have_content("Supermarket: Fry's Foods")
        expect(page).to have_content("Number of Customers: 1")
      end

      within "#item-#{@apples.id}" do
        expect(page).to have_content("Item: Apples")
        expect(page).to have_content("Price: $3")
        expect(page).to have_content("Supermarket: Fry's Foods")
        expect(page).to have_content("Number of Customers: 1")
      end

      within "#item-#{@carrots.id}" do
        expect(page).to have_content("Item: Carrots")
        expect(page).to have_content("Price: $1")
        expect(page).to have_content("Supermarket: Fry's Foods")
        expect(page).to have_content("Number of Customers: 2")
      end
    end
  end
end
