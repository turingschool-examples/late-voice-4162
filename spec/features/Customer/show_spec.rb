require "rails_helper"

RSpec.describe "Customer shoe page" do
  before(:each) do
    
    @customer = Customer.create!(name: "Sally")
    @supermarket = Supermarket.create!(name: "Corner Market", location: "123 Food St")
    @item1 = @supermarket.items.create!(name: "banana", price: 1)
    @item2 = @supermarket.items.create!(name: "apple", price: 2)
    @customeritem = CustomerItem.create!(customer_id: @customer.id, item_id: @item1.id)
  end

    # Story 1

    # As a visitor, 
    # When I visit a customer show page,
    # I see the customer's name,
    # And I see its a list of its items
    # including the item's name, price, and the name of the supermarket that it belongs to.

    it "Show's a specific customer's details and items" do
    

        visit "/customers/#{@customer.id}"
        
        expect(page).to have_content(@customer.name)
        expect(page).to have_content(@item1.name)
        expect(page).to have_content(@item1.supermarket.name)
        expect(page).to have_content(@item1.price)

        
    
       
    end


    # Story 2

      # As a visitor,
      # When I visit a customer's show page,
      # Then I see a form to add an item to this customer.
      # When I fill in a field with the id of an existing item,
      # And I click submit,
      # Then I am redirected back to the customer's show page, 
      # And I see the item now listed under this customer's items.
      # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)

    it "adds an item to customer" do

      visit "/customers/#{@customer.id}"

      expect(page).to have_content("add an item")

      fill_in :item_id, with: @item2.id
      click_on "Submit"

    expect(current_path).to eq("/customers/#{@customer.id}")
    expect(page).to have_content(@item2.name)


    end


end