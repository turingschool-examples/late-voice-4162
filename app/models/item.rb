class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customer_items, dependent: :destroy
  has_many :customers, through: :customer_items
end