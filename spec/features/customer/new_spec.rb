require 'rails_helper'

RSpec.describe 'Customer Show page' do
  before do
    @linda = Customer.create!(name: "Linda")
    
    @smiths = Supermarket.create!(name: "Smiths", location: "Sandy")
    @soopers = Supermarket.create!(name: "King Soopers", location: "Denver")
    
    @milk = Item.create!(name: "Milk", price: 4, supermarket: @smiths)
    @bread = Item.create!(name: "Bread", price: 2, supermarket: @smiths)
    @toothpaste = Item.create!(name: "Toothpaste", price: 1, supermarket: @soopers)
    
    CustomerItem.create!(customer: @linda, item: @milk)
    CustomerItem.create!(customer: @linda, item: @bread)
    CustomerItem.create!(customer: @linda, item: @toothpaste)
    # @batteries = Item.create!(name: "Batteries", price: 7)
    # @toy = Item.create!(name: "Toy", price: )
  end


end