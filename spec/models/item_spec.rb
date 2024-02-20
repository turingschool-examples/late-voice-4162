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

  describe '#customer_count' do
    it 'retireves count of customers that belong to item' do
      alain = Customer.create!(name: "Alain King")
      odell = Customer.create!(name: "Odell Mac")
      wilson = Customer.create!(name: "Wilson Lora")
      janay = Customer.create!(name: "Janay Tate")

      walmart = Supermarket.create!(name: "Walmart", location: "900 Walmart Drive")
      target = Supermarket.create!(name: "Target", location: "800 Target Drive")

      guac = walmart.items.create!(name: "Guacamole", price: 5)
      mango = walmart.items.create!(name: "Mango", price: 2)
      popcorn = target.items.create!(name: "Popcorn", price: 3)
      almonds = target.items.create!(name: "Almonds", price: 6)

      alain.items << [mango, almonds]
      odell.items << [guac, popcorn]
      wilson.items << [mango, almonds, guac, popcorn]
      janay.items << [almonds, mango, popcorn]

      expect(mango.customer_count).to eq(3)
      expect(guac.customer_count).to eq(2)
      expect(popcorn.customer_count).to eq(3)
      expect(almonds.customer_count).to eq(3)
    end
  end
end