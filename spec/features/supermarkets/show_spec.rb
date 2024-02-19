require "rails_helper"

RSpec.describe "Show Page" do
  before(:each) do
    betty = Customer.create!(name: "Betty")
    jake = Customer.create!(name: "Jake")
    frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    bananas = Item.create!(name: "Bananas", price: 1, supermarket_id: frys.id )
    apples = Item.create!(name: "Apples", price: 3, supermarket_id: frys.id)
    carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: frys.id)
    CustomerItem.create!(customer_id: betty.id, item_id: bananas.id)
    CustomerItem.create!(customer_id: betty.id, item_id: apples.id)
    CustomerItem.create!(customer_id: jake.id, item_id: carrots.id)

    visit supermarket_path(frys)
  end

  describe "Extension" do
    it "displays a unique list of all customers" do
      expect(page).to have_content("All Customers: Betty, Jake")
      expect(page).to have_no_content("Billy")
    end
  end
end
