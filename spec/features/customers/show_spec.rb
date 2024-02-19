require 'rails_helper'

RSpec.describe 'Customer Show Page', type: :feature do
 describe 'As a Visitor' do
  before(:each) do
    @customer_isaac = Customer.create!(name: "Isaac")
    @customer_jack = Customer.create!(name: "Jack")
    @customer_noah = Customer.create!(name: "Noah")

    @walmart = Supermarket.create!(name: "Walmart Summit", location: "150 Summit Blvd")
    @costco = Supermarket.create!(name: "Costco", location: "20 Marshall Rd")
    @safeway = Supermarket.create!(name: "Safeway", location: "455 Coalton Rd")

    @milk = @walmart.items.create!(name: "Milk", price: 2)
    @banana = @walmart.items.create!(name: "Banana", price: 1)
    @apple = @costco.items.create!(name: "Apple", price: 5)
    @popcorn = @costco.items.create!(name: "Pop Corn", price: 8)
    @mushroom = @safeway.items.create!(name: "Mushroom", price: 1)
    @kiwi = @safeway.items.create!(name: "Kiwi", price: 3)

    @customer_isaac.items << @milk
    @customer_isaac.items << @popcorn
    @customer_noah.items << @apple
    @customer_noah.items << @kiwi
    @customer_jack.items << @mushroom
    @customer_jack.items << @banana
  end
  
  # User Story 1
  it 'displays customers name and a detailed list of its items' do
    # As a visitor, 
    # When I visit a customer show page,
    visit "/customers/#{@customer_isaac.id}"
    # I see the customer's name,
    expect(page).to have_content("Customer's Name: Isaac")
    
    within ".customeritems-#{@customer_isaac.id}" do
      # And I see its a list of its items
      expect(page).to have_content("List of Added Items:")
      # including the item's name, price, and the name of the supermarket that it belongs to.
      expect(page).to have_content("Item's Name: Milk")
      expect(page).to have_content("Item's Price: 2")
      expect(page).to have_content("Supermarket's Name: Walmart")

      expect(page).to have_content("Item's Name: Pop Corn")
      expect(page).to have_content("Item's Price: 8")
      expect(page).to have_content("Supermarket's Name: Costco")
    end
  end

  #User Story 2
  it "displays a form to succesfully add an item to this customer" do
    # As a visitor,
    # When I visit a customer's show page,
    visit "/customers/#{@customer_isaac.id}"
    
    # Then I see a form to add an item to this customer.
    expect(page).to have_content("Add Item")
    
    # When I fill in a field with the id of an existing item,
    fill_in("item_id", with: @kiwi.id)
    # And I click submit,
    click_button("Submit")
    # Then I am redirected back to the customer's show page, 
    expect(current_path).to eq("/customers/#{@customer_isaac.id}")
    # And I see the item now listed under this customer's items.
    within ".customeritems-#{@customer_isaac.id}" do
      expect(page).to have_content("Item's Name: Kiwi")
      expect(page).to have_content("Item's Price: 3")
      expect(page).to have_content("Supermarket's Name: Safeway")
    end
    # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)
  end
 end
end