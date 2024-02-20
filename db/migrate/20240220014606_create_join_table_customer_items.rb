class CreateJoinTableCustomerItems < ActiveRecord::Migration[7.1]
  def change
    create_join_table :items, :customers do |t|
      t.index [:item_id, :customer_id]
      t.index [:customer_id, :item_id]
    end
  end
end
