require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  before(:each) do
    @supermarket_1 = Supermarket.create!(name: "Ralphs", location: "Over There St.")
    @supermarket_2 = Supermarket.create!(name: "Dougs", location: "Over Here St.")
    @customer_1 = Customer.create!(name: "Alex Long")
    @customer_2 = Customer.create!(name: "Alex Short")
    @customer_3 = Customer.create!(name: "Alex Medium")
    @item_1 = @supermarket_1.items.create!(name: "Apple", price: 5)
    @item_2 = @supermarket_1.items.create!(name: "Banana", price: 2)
    @item_3 = @supermarket_1.items.create!(name: "Orange", price: 3)
    @item_4 = @supermarket_2.items.create!(name: "Onion", price: 1)
    @item_5 = @supermarket_2.items.create!(name: "Bell Pepper", price: 4)
    @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
    @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
    @customer_item_3 = CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_3.id)
    @customer_item_4 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)
    @customer_item_5 = CustomerItem.create!(customer_id: @customer_3.id, item_id: @item_3.id)
    @customer_item_6 = CustomerItem.create!(customer_id: @customer_3.id, item_id: @item_4.id)
  end

  describe 'Instance Methods' do
    describe '#customer_count' do
      it 'can count how many customers have purchased an item' do
        expect(@item_1.customer_count).to eq(1)
        expect(@item_2.customer_count).to eq(1)
        expect(@item_3.customer_count).to eq(3)
        expect(@item_4.customer_count).to eq(1)
        expect(@item_5.customer_count).to eq(0)
      end
    end
  end
end