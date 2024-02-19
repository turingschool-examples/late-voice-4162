class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customeritems
  has_many :customers, through: :customeritems
end