class Supermarket < ApplicationRecord
  has_many :items

  def distinct_customers
    Customer.joins(:items).where(items: {supermarket_id: self.id}).distinct
  end
end