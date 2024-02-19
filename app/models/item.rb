class Item < ApplicationRecord
  belongs_to :supermarket
  has_many :customeritems
  has_many :customers, through: :customeritems

  def purchase_count
    customers.count
  end
end