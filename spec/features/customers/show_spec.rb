require "rails_helper"

RSpec.describe "Show Page" do
  before(:each) do
    @customer_1 = Customer.create!(name: "Barry")
    @supermarket_1 = Supermarket.create!(name: "Crest Foods", location: "Oklahoma City")
    @item_1 = Item.create!(name: "Bacon", price: "5", supermarket_id: @supermarket_1.id )
    @item_2 = Item.create!(name: "Eggs", price: "2", supermarket_id: @supermarket_1.id )
    @item_3 = Item.create!(name: "Sausage", price: "4", supermarket_id: @supermarket_1.id )
    @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
    @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)

    visit "/customers/#{@customer_1.id}"
  end

  describe "User Story 1 - Customer Show Page" do
    it "Display's respective customer's name" do
      expect(page).to have_content("Customer Name: Barry")
    end

    it "Displays a list of respective customer's items" do
      expect(page).to have_content("Barry's Items:")

      within "#item-#{@item_1.id}" do
        expect(page).to have_content("Item: Bacon")
        expect(page).to have_content("Price: $5")
        expect(page).to have_content("Supermarket: Crest Foods")
      end

      within "#item-#{@item_2.id}" do
        expect(page).to have_content("Item: Eggs")
        expect(page).to have_content("Price: $2")
        expect(page).to have_content("Supermarket: Crest Foods")
      end
    end
  end

  describe "User Story 2 - Customer Add Item" do
    it "has a form to allow the respective customer to add an item" do
      expect(page).to have_content("Add an Item:")
      expect(page).to have_field(:item_id)
      expect(page).to have_button("Submit")

      fill_in :item_id, with: @item_3.id
      click_button

      expect(page.current_path).to eq("/customers/#{@customer_1.id}")

      expect(page).to have_content("Sausage")
    end
  end
end