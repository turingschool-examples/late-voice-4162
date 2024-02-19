class Customer < ApplicationRecord
    belongs_to :supermarket
    has_many :customer_items
    has_many :items, through: :customer_items

    def add_items(item_id)
        @item = Item.find(item_id)

        self.items << item        
    end
end
