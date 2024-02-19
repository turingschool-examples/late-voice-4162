require 'rails_helper'

RSpec.describe Supermarket, type: :model do
  describe 'relationships' do
    it { should have_many :items }
  end

  describe 'distinct_customers' do
    it 'returns a list of unique customers that shopped at the supermarket' do
      publix = Supermarket.create!(name: "Publix", location: "East Atlanta Village")

      john = Customer.create!(name: "John Smith")
      peter = Customer.create!(name: "Peter Jones")
      lucy = Customer.create!(name: "Lucy Veron")

      bread = Item.create!(name: "Bread", price: 5, supermarket_id: publix.id)

      lucy_item = CustomerItem.create!(customer_id: lucy.id, item_id: bread.id)
      peter_item = CustomerItem.create!(customer_id: peter.id, item_id: bread.id)
      john_item = CustomerItem.create!(customer_id: john.id, item_id: bread.id)

      expect(publix.distinct_customers).to eq([john, peter, lucy])
    end
  end
end