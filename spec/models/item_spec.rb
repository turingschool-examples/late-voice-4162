require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe 'supermarket_name_by_item' do
    it 'return the supermarket name based on the item passed' do
      supermarket = Supermarket.create!(name: "Whole Foods", location: "Decatur")
      item = Item.create!(name: "Eggs", price: 10, supermarket_id: supermarket.id)

      expect(item.supermarket_name_by_item).to eq("Whole Foods")
    end
  end
end