require 'rails_helper'

RSpec.describe 'Supermarket Show Page', type: :feature do
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

  #Extension
  it 'displays a unique list of all customers that have shopped at the supermarket.' do
    # As a visitor,
    # When I visit a supermarket's show page,
    visit "supermarkets/#{@walmart.id}"
    # Then I see a unique list of all customers that have shopped at the supermarket.
    expect(page).to have_content("Clients Who Shopped at Walmart")
    expect(page).to have_content("Isaac")
    expect(page).to have_content("Jack")
    expect(page).to have_content("Noah")
  end
 end
end