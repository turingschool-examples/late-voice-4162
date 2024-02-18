require 'rails_helper'

RSpec.describe Item, type: :model do
  let!(:whole_foods) { Supermarket.create!(name: "Whole Foods", location: "San Francisco") }

  let!(:milk) { whole_foods.items.create!(name: "milk", price: 5.99 ) }
  let!(:cheese) { whole_foods.items.create!(name: "cheese", price: 12.99 ) }

  let!(:tom) { Customer.create!(name: "Tom") }
  let!(:jerry) { Customer.create!(name: "Jerry") }

  let!(:customer_item_1) { CustomerItem.create!(customer_id: tom.id, item_id: milk.id) }
  let!(:customer_item_3) { CustomerItem.create!(customer_id: tom.id, item_id: cheese.id) }
  let!(:customer_item_4) { CustomerItem.create!(customer_id: jerry.id, item_id: milk.id) }

  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe '#customer_count' do
    it "returns the number of customers who bought the items" do
      expect(milk.customer_count).to eq(2)
      expect(cheese.customer_count).to eq(1)
    end
  end
end
