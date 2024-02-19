require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe 'relationships' do
    it { should have_many(:customer_items) }
    it { should have_many(:items).through(:customer_items) }
    it { should have_many(:supermarkets).through(:items) }
  end

  before do
    @betty = Customer.create!(name: "Betty")
    @frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    @bananas = Item.create!(name: "Bananas", price: "1", supermarket_id: @frys.id )
    @apples = Item.create!(name: "Apples", price: "3", supermarket_id: @frys.id)
    @carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: @frys.id)
    @bettys_bananas = CustomerItem.create!(customer_id: @betty.id, item_id: @bananas.id)
    @bettys_apples = CustomerItem.create!(customer_id: @betty.id, item_id: @apples.id)
    @jake = Customer.create!(name: "Jake")
    @jakes_carrots = CustomerItem.create!(customer_id: @jake.id, item_id: @carrots.id)


    @billy = Customer.create!(name: "Billy")
    @walmart = Supermarket.create!(name: "Walmart")
    @hotdog = Item.create!(name: "Hot dogs", price: 1, supermarket_id: @walmart.id)
    CustomerItem.create!(customer_id: @billy.id, item_id: @hotdog.id)
  end
  describe "Instance methods" do
    it "#unique_customers_for_supermarket" do
      expect(Customer.unique_customers_for_supermarket(@frys.id).sort).to eq(["Betty", "Jake"])
      expect(Customer.unique_customers_for_supermarket(@walmart.id).sort).to eq(["Billy"])
    end
  end
end
