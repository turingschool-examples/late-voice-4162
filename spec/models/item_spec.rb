require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it {should have_many :customer_items}
    it {should have_many(:customers).through(:customer_items)}
  end

  describe '#supermarket_name' do
    it 'retrieves the name of a supermarket for the item' do
      walmart = Supermarket.create!(name: "Walmart", location: "900 Walmart Drive")
      target = Supermarket.create!(name: "Target", location: "800 Target Drive")

      guac = walmart.items.create!(name: "Guacamole", price: 5)
      mango = walmart.items.create!(name: "Mango", price: 2)
      popcorn = target.items.create!(name: "Popcorn", price: 3)
      almonds = target.items.create!(name: "Almonds", price: 6)


      expect(guac.supermarket_name).to eq("Walmart")
      expect(almonds.supermarket_name).to eq("Target")
    end
  end
end