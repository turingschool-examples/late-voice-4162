require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe '#supermarket_name_by_item' do
    it 'return the supermarket name based on the item passed' do
      supermarket = Supermarket.create!(name: "Whole Foods", location: "Decatur")
      item = Item.create!(name: "Eggs", price: 10, supermarket_id: supermarket.id)

      expect(item.supermarket_name_by_item).to eq("Whole Foods")
    end
  end

  describe '#total_times_sold' do
    it 'returns the count of times an item was sold' do
      publix = Supermarket.create!(name: "Publix", location: "East Atlanta Village")

      john = Customer.create!(name: "John Smith")
      peter = Customer.create!(name: "Peter Jones")
      lucy = Customer.create!(name: "Lucy Veron")

      bread = Item.create!(name: "Bread", price: 5, supermarket_id: publix.id)

      lucy_item = CustomerItem.create!(customer_id: lucy.id, item_id: bread.id)

      peter_item = CustomerItem.create!(customer_id: peter.id, item_id: bread.id)

      expect(bread.total_times_sold).to eq(2)

      john_item = CustomerItem.create!(customer_id: peter.id, item_id: bread.id)

      expect(bread.total_times_sold).to eq(3)
    end
  end
end