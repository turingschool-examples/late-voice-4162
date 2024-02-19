class Supermarket < ApplicationRecord
  has_many :items

  def list_customers
    Customer.joins(items: :customeritems).where('items.supermarket_id' => id).distinct
  end
end