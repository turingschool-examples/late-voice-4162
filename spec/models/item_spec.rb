require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customeritems}
    it { should have_many(:customers).through(:customeritems) }
  end

  describe 'instance methods' do
    describe '#purchase_count' do
      it "returns the correct count of purchases" do
        @customer_isaac = Customer.create!(name: "Isaac")
        @customer_jack = Customer.create!(name: "Jack")
        @customer_noah = Customer.create!(name: "Noah")

        @walmart = Supermarket.create!(name: "Walmart Summit", location: "150 Summit Blvd")
        @costco = Supermarket.create!(name: "Costco", location: "20 Marshall Rd")
        @safeway = Supermarket.create!(name: "Safeway", location: "455 Coalton Rd")

        @milk = @walmart.items.create!(name: "Milk", price: 2)
        @banana = @walmart.items.create!(name: "Banana", price: 1)
        @apple = @costco.items.create!(name: "Apple", price: 5)
        @popcorn = @costco.items.create!(name: "Pop Corn", price: 8)
        @mushroom = @safeway.items.create!(name: "Mushroom", price: 1)
        @kiwi = @safeway.items.create!(name: "Kiwi", price: 3)

        @customer_isaac.items << @milk
        @customer_isaac.items << @popcorn
        @customer_isaac.items << @kiwi
        @customer_noah.items << @apple
        @customer_noah.items << @kiwi
        @customer_noah.items << @milk
        @customer_jack.items << @mushroom
        @customer_jack.items << @banana
        @customer_jack.items << @milk

        expect(@milk.purchase_count).to eq(3)
        expect(@popcorn.purchase_count).to eq(1)
        expect(@apple.purchase_count).to eq(1)
        expect(@mushroom.purchase_count).to eq(1)
        expect(@banana.purchase_count).to eq(1)
        expect(@kiwi.purchase_count).to eq(2)
        
      end
    end
  end
end