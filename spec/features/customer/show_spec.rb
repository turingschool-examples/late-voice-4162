require 'rails_helper'

RSpec.describe 'Customer Show page' do
  before do
    @linda = Customer.create!(name: "Linda")
    
    @smiths = Supermarket.create!(name: "Smiths", location: "Sandy")
    @soopers = Supermarket.create!(name: "King Soopers", location: "Denver")
    
    @milk = Item.create!(name: "Milk", price: 4, supermarket: @smiths)
    @bread = Item.create!(name: "Bread", price: 2, supermarket: @smiths)
    @batteries = Item.create!(name: "Batteries", price: 7, supermarket: @smiths)
    @toothpaste = Item.create!(name: "Toothpaste", price: 1, supermarket: @soopers)
    
    CustomerItem.create!(customer: @linda, item: @milk)
    CustomerItem.create!(customer: @linda, item: @bread)
    CustomerItem.create!(customer: @linda, item: @toothpaste)
    # @toy = Item.create!(name: "Toy", price: )
  end

  it 'Dispays customer and list of items with their attributes' do
    # When I visit a customer show page,
    visit "/customers/#{@linda.id}"
    
    # I see the customer's name,
    expect(page).to have_content("Name: #{@linda.name}")

    # And I see its a list of its items
    # including the item's name, price, and the name of the supermarket that it belongs to.
    within("#item-#{@milk.name}") do
      expect(page).to have_content(@milk.price)
      expect(page).to have_content(@bread.supermarket.name)
    end
  
    within("#item-#{@bread.name}") do
      expect(page).to have_content(@bread.price)
      expect(page).to have_content(@bread.supermarket.name)
    end
    
    within("#item-#{@toothpaste.name}") do
      expect(page).to have_content(@toothpaste.price)
      expect(page).to have_content(@toothpaste.supermarket.name)
    end
  end
  
  
  it "Can add an item to a customer through the show page" do
    # When I visit a customer's show page,
    visit "/customers/#{@linda.id}"
    save_and_open_page
      # Then I see a form to add an item to this customer.
      expect(page).to have_field("Add Item")
      expect(page).to have_button("Add Item")
      # When I fill in a field with the id of an existing item,
      fill_in "Add Item", with:"Batteries"
      # And I click submit,
      click_button "Add Item"
      # Then I am redirected back to the customer's show page, 
      expect(current_path).to eq("/customers/#{@linda.id}")
      # And I see the item now listed under this customer's items.
      expect(page).to have_content("Item: Batteries")
      expect(page).to have_content("Price: $7")
      expect(page).to have_content("Supermarket: Smiths")
      # (You do not have to test for a sad path, for example if the ID submitted is not an existing item)
  end
end