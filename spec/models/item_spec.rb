require 'rails_helper'

RSpec.describe Item, type: :model do
  before(:each) do
    @customer_1 = Customer.create!(name: "Barry")
    @supermarket_1 = Supermarket.create!(name: "Crest Foods", location: "Oklahoma City")
    @item_1 = Item.create!(name: "Bacon", price: "5", supermarket_id: @supermarket_1.id )
    @item_2 = Item.create!(name: "Eggs", price: "2", supermarket_id: @supermarket_1.id )
    @item_3 = Item.create!(name: "Sausage", price: "4", supermarket_id: @supermarket_1.id )
    @customer_item_1 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_1.id)
    @customer_item_2 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_2.id)
    @customer_item_3 = CustomerItem.create!(customer_id: @customer_1.id, item_id: @item_3.id)

    @customer_2 = Customer.create!(name: "Larry")
    @customer_item_4 = CustomerItem.create!(customer_id: @customer_2.id, item_id: @item_1.id)
  end

  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customers }
  end

  describe "Instance Methods" do
    describe "#customer_count" do
      it "Counts the number of customers an item belongs to" do
        expect(@item_1.customer_count).to eq(2)
        expect(@item_2.customer_count).to eq(1)
        expect(@item_3.customer_count).to eq(1)
      end
    end
  end
end