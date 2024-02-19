class RenameCustomersItemsToCustomerItems < ActiveRecord::Migration[7.1]
  def change
    rename_table :customers_items, :customer_items
  end
end
