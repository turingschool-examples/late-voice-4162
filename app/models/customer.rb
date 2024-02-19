class Customer < ApplicationRecord
  has_many :customeritems
  has_many :items, through: :customeritems
end
