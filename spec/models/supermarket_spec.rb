require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  before do
    @betty = Customer.create!(name: "Betty")
    @jake = Customer.create!(name: "Jake")
    @frys = Supermarket.create!(name: "Fry's Foods", location: "Maricopa")
    @bananas = Item.create!(name: "Bananas", price: "1", supermarket_id: @frys.id )
    @apples = Item.create!(name: "Apples", price: "3", supermarket_id: @frys.id)
    @carrots = Item.create!(name: "Carrots", price: 1, supermarket_id: @frys.id)
    CustomerItem.create!(customer_id: @betty.id, item_id: @bananas.id)
    CustomerItem.create!(customer_id: @betty.id, item_id: @apples.id)
    CustomerItem.create!(customer_id: @jake.id, item_id: @carrots.id)

    @billy = Customer.create!(name: "Billy")
    @walmart = Supermarket.create!(name: "Walmart")
    @hotdog = Item.create!(name: "Hot dogs", price: 1, supermarket_id: @walmart.id)
    CustomerItem.create!(customer_id: @billy.id, item_id: @hotdog.id)
  end

  describe "instance methods" do
    describe "#unique_list_of_customers" do
      it "returns a unique list of customers" do
        expect(@frys.unique_list_of_customers.sort).to eq(["Betty", "Jake"])
        expect(@walmart.unique_list_of_customers).to eq(["Billy"])
      end
    end
  end
end
