class Customer < ApplicationRecord
  has_many :customer_items, dependent: :destroy
  has_many :items, through: :customer_items
end
