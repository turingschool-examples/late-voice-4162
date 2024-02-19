class Supermarket < ApplicationRecord
  has_many :items
  has_many :customer_items, through: :items
  has_many :customers, through: :customer_items

  def unique_customers
    customers.distinct
  end
  
end