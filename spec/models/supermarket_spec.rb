require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :items }
    it { should have_many(:customer_items).through(:items) }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe 'instance methods' do
    it "#current_customers" do 
    cust_1 = Customer.create!(name: "larry")
    cust_2 = Customer.create!(name: "Logan")
    cust_3 = Customer.create!(name: "Jessie")

    sup_1 = Supermarket.create!(name: "gen name", location: "mn")
    sup_2 = Supermarket.create!(name: "gen name 2", location: "mn")

    item_1 = sup_1.items.create(name: "item name 1", price: 1)
    item_2 = sup_1.items.create(name: "item name 2", price: 1)
    item_3 = sup_1.items.create(name: "item name 3", price: 1)

    CustomerItem.create!(item_id: item_1.id, customer_id: cust_1.id)
    CustomerItem.create!(item_id: item_2.id, customer_id: cust_2.id)

    expect(sup_1.current_customers).to eq([cust_1, cust_2])
    expect(sup_2.current_customers).to eq([])
    end
  end
end

