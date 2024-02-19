class Customer < ApplicationRecord
  has_many :customer_items
  has_many :items, through: :customer_items
  has_many :supermarkets, through: :items

  def self.unique_customers_for_supermarket(supermarket_id)
    Customer.joins(:supermarkets).where("items.supermarket_id = ?", supermarket_id).distinct.pluck(:name)
    # This would lead to @customers = Customer.unique_customers_for_supermarket in the supermarkets#show
  end
end
