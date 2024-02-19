class AddSupermarketToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_reference :customers, :supermarket, null: false, foreign_key: true
  end
end
