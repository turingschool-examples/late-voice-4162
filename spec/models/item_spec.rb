require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  before(:each) do 
    @supermarket1 = Supermarket.create!(name: "Corner Market", location: "123 Food St.")
    @supermarket2 = Supermarket.create!(name: "Mimi Market", location: "456 Yum St.")

    @customer1 = Customer.create!(name: "Sally Shopper")
    @customer2 = Customer.create!(name: "Molly Spender")

    @item1 = @supermarket1.items.create!(name: "Apple", price: 2)
    @item2 = @supermarket1.items.create!(name: "Banana", price: 1)
    @item3 = @supermarket2.items.create!(name: "Bread", price: 3)
    
    @customer1.items << @item1
    @customer1.items << @item2
  end

  describe "#customers_count" do
    it 'returns the count of customers that bought that item' do
      
      expect(@item1.customers_count).to eq(1)
      expect(@item2.customers_count).to eq(1)
    end
  end
end