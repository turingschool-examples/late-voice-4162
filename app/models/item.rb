class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items
  has_many :customers, through: :customer_items

  def number_of_customers
    self.customers.count
  end

  def self.unique_list_of_customers(supermarket_id)
    Item.joins(:customers).where("items.supermarket_id = ?", supermarket_id).distinct.pluck("customers.name")
    # This would lead to @customer.items.unique_list_of_customers in "supermarkets/:id"
  end
end
