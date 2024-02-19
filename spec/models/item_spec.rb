require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :supermarket }
    it { should have_many :customer_items }
    it { should have_many(:customers).through(:customer_items) }
  end

  describe "instance methods" do
    let!(:customer_1) {Customer.create!(name: "Susan")}
    let!(:customer_2) {Customer.create!(name: "Anna")}
    let!(:supermarket_1) {Supermarket.create!(name: "Walmart", location: "E 53rd St.")}
    let!(:item_1) {supermarket_1.items.create!(name: "milk", price: 4)}
    let!(:customer_item_1) {CustomerItem.create!(customer: customer_1, item: item_1)}
    let!(:customer_item_2) {CustomerItem.create!(customer: customer_2, item: item_1)}

    it "counts item's customers" do
      expect(item_1.customer_count).to eq(2)
    end
  end
end