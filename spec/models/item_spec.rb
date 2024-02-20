require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe "instance methods" do
    it "#purchase_count" do 
      cust_1 = Customer.create!(name: "larry")

      sup_1 = Supermarket.create!(name: "gen name", location: "mn")

      item_1 = sup_1.items.create(name: "item name 1", price: 1)
      item_2 = sup_1.items.create(name: "item name 2", price: 1)
      item_3 = sup_1.items.create(name: "item name 3", price: 1)

      CustomerItem.create!(item_id: item_1.id, customer_id: cust_1.id)
      CustomerItem.create!(item_id: item_2.id, customer_id: cust_1.id)

      expect(item_1.purchase_count).to eq(1)
      expect(item_3.purchase_count).to eq(0)
    end
  end
end