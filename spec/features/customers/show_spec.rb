require "rails_helper"

RSpec.describe "Show Page" do
  before(:each) do
    @betty = Customer.create!(name: "Betty")
    @frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    @bananas = Item.create!(name: "Bananas", price: "1", supermarket_id: @frys.id )
    @apples = Item.create!(name: "Apples", price: "3", supermarket_id: @frys.id)
    @carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: @frys.id)
    @bettys_bananas = CustomerItem.create!(customer_id: @betty.id, item_id: @bananas.id)
    @bettys_apples = CustomerItem.create!(customer_id: @betty.id, item_id: @apples.id)

    visit customer_path(@betty)
  end

  describe "User Story 1" do
    it "displays the customer's name" do
      expect(page).to have_content("Customer's Name: Betty")
    end

    it "displays a list of customer's items" do
      expect(page).to have_content("Betty's Items:")

      within "#item-#{@bananas.id}" do
        expect(page).to have_content("Item: Bananas")
        expect(page).to have_content("Price: $1")
        expect(page).to have_content("Supermarket: Fry's Foods")
      end

      within "#item-#{@apples.id}" do
        expect(page).to have_content("Item: Apples")
        expect(page).to have_content("Price: $3")
        expect(page).to have_content("Supermarket: Fry's Foods")
      end

      expect(page).to have_no_content("Carrots")
    end
  end

  describe "User Story 2" do
    it "displays a form to add an item" do
      expect(page).to have_content("Add Item to Betty's Cart")
      expect(page).to have_field(:item_id)
      expect(page).to have_button("Add To List")

      fill_in :item_id, with: @carrots.id
      click_button

      expect(page.current_path).to eq(customer_path(@betty))

      expect(page).to have_content("Carrots")
    end
  end
end
