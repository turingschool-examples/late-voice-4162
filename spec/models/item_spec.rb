require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @betty = Customer.create!(name: "Betty")
    @jake = Customer.create!(name: "Jake")
    @frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    @bananas = Item.create!(name: "Bananas", price: "1", supermarket_id: @frys.id )
    @apples = Item.create!(name: "Apples", price: "3", supermarket_id: @frys.id)
    @carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: @frys.id)
    @bettys_bananas = CustomerItem.create!(customer_id: @betty.id, item_id: @bananas.id)
    @bettys_apples = CustomerItem.create!(customer_id: @betty.id, item_id: @apples.id)
    @bettys_carrots = CustomerItem.create!(customer_id: @betty.id, item_id: @carrots.id)
    @jakes_carrots = CustomerItem.create!(customer_id: @jake.id, item_id: @carrots.id)
  end

  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customers}
  end


  describe "instance methods" do
    describe "#number_of_customers" do
      it "counts the number of Customers that belong to the Item" do
        expect(@carrots.number_of_customers).to eq(2)
        expect(@apples.number_of_customers).to eq(1)
      end
    end
  end
end
