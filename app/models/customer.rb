class Customer < ApplicationRecord
  has_many :customers_items
  has_many :items, through: :customer_items
end