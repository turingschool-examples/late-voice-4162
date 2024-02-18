require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items}
    it { should have_many(:customers).through(:customer_items)}
  end

  it 'supermarket_name' do
    supermarket_1 = Supermarket.create!(name: "Walmart", location: " 1223 DRIVE" )
     supermarket_2 = Supermarket.create!(name: "Target", location: " 1456 BLVD" )

     item_1 = supermarket_1.items.create!(name: "Gum", price: 1)
     item_2 = supermarket_2.items.create!(name: "Apple", price: 2)
     item_3 = supermarket_1.items.create!(name: "Chips", price: 3)
     item_4 = supermarket_2.items.create!(name: "Milk", price: 4)
     item_5 = supermarket_1.items.create!(name: "Cookies", price: 2)

     customer_1 = Customer.create!(name: "Bob")
     customer_2 = Customer.create!(name: "Rodrigo")


     CustomerItem.create(customer_id: customer_1.id, item_id: item_1.id)
     CustomerItem.create(customer_id: customer_2.id, item_id: item_2.id)
     CustomerItem.create(customer_id: customer_2.id, item_id: item_3.id)
     CustomerItem.create(customer_id: customer_1.id, item_id: item_4.id)

     expect(item_1.supermarket_name).to eq("Walmart")
     expect(item_4.supermarket_name).to eq("Target")
  end
end