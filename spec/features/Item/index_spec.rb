require "rails_helper"

RSpec.describe "Item Index page" do
  before(:each) do
    
    @customer = Customer.create!(name: "Sally")
    @supermarket = Supermarket.create!(name: "Corner Market", location: "123 Food St")
    @item1 = @supermarket.items.create!(name: "banana", price: 1)
    @item2 = @supermarket.items.create!(name: "apple", price: 2)
    @customeritem = CustomerItem.create!(customer_id: @customer.id, item_id: @item1.id)
  end

  it "Show's a specific customer's details and items" do
    

    visit "/items"
    
    expect(page).to have_content(@item1.name)
    expect(page).to have_content(@item2.name)

    expect(page).to have_content(@item1.supermarket.name)
    expect(page).to have_content(@item1.price)
    expect(page).to have_content(@item2.price)
    expect(page).to have_content(1)


  end
   
end