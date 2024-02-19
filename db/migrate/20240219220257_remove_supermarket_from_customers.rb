class RemoveSupermarketFromCustomers < ActiveRecord::Migration[7.1]
  def change
    remove_reference :customers, :supermarket, null: false, foreign_key: true
  end
end
