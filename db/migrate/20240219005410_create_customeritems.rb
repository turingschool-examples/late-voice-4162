class CreateCustomeritems < ActiveRecord::Migration[7.1]
  def change
    create_table :customeritems do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true

      t.timestamps
    end
  end
end
