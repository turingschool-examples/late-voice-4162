require 'rails_helper'

RSpec.describe "customer show page" do
    it "shows customer name and items" do
        # Story 1
         customer_1 = Customer.create!(name: "Lance")
        # As a visitor, 
        # When I visit a customer show page,
        visit "/customers/#{customer_1.id}"
        # I see the customer's name,
        expect(page).to have_content(customer_1.name)
        # And I see its a list of its items
        # including the item's name, price, and the name of the supermarket that it belongs to.
    end
end
