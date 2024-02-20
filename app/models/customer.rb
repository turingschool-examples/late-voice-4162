class Customer < ApplicationRecord
  belongs_to :item_id
  belongs_to :customer
end