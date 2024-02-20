require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many(:customers).through(:customer_items)}
    it { should have_many :customer_items}
  end

  it 'name_supermaket' do
    market_1 = Supermarket.create!(name: "Costco", location: "1450 ST")
    market_2 = Supermarket.create(name: "Aldi", location: "1024 DV")

    item_1 = market_1.items.create!(name: "Rice", price: 20)
    item_2 = market_2.items.create!(name: "Oreos", price: 4)

    customer_1 = Customer.create!(name: "Luis")
    customer_2 = Customer.create!(name: "Walter")

    CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
    CustomerItem.create(customer_id: customer_2.id, item_id: item_2.id)

    expect(item_1.name_supermarket).to eq("Costco")
    expect(item_2.name_supermarket).to eq("Aldi")
  end
end