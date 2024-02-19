require 'rails_helper'

RSpec.describe 'Items Index Page', type: :feature do
 describe 'As a visitor' do
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
    @customer_isaac.items << @kiwi
    @customer_noah.items << @apple
    @customer_noah.items << @kiwi
    @customer_noah.items << @milk
    @customer_jack.items << @mushroom
    @customer_jack.items << @banana
    @customer_jack.items << @milk
  end

  # User Story 3
  it 'displays a detailed list of all items' do
    # As a visitor,
    # When I visit the items index page,
    visit "/items"
    # Then I see a list of all items
    expect(page).to have_content("Items")
    # including the item's name, price, and the name of the supermarket that it belongs to
    within "#item-#{@milk.id}" do
      expect(page).to have_content("Item's Name: Milk")
      expect(page).to have_content("Item's Price: 2")
      expect(page).to have_content("Supermarket's Name: Walmart")
      # and the count of customers that bought that item.
      expect(page).to have_content("Bought by: 3 customer(s)")
    end
    
    within "#item-#{@popcorn.id}" do
      expect(page).to have_content("Item's Name: Pop Corn")
      expect(page).to have_content("Item's Price: 8")
      expect(page).to have_content("Supermarket's Name: Costco")
      expect(page).to have_content("Bought by: 1 customer(s)")
    end

    within "#item-#{@kiwi.id}" do
      expect(page).to have_content("Item's Name: Kiwi")
      expect(page).to have_content("Item's Price: 3")
      expect(page).to have_content("Supermarket's Name: Safeway")
      expect(page).to have_content("Bought by: 2 customer(s)")
    end
  end
 end
end