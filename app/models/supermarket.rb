class Supermarket < ApplicationRecord
  has_many :items

  def unique_list_of_customers
    self.items.joins(:customers).distinct.pluck("customers.name")
    # Customer.joins(:supermarkets).where("items.supermarket_id = ?", supermarket_id).distinct.pluck(:name)
    # You would need to pass in supermarket_id here
  end
end
