class Customer < ApplicationRecord
    belongs_to :supermarket
    has_many :customer_items
    has_many :items, through: :customer_items

    def add_items
        @customer = Customer.find(params[:customer_id])
        @item = Item.find(params[:item_id])

        @customer.items << @item
        
        redirect_to "/customers/:id"
    end
end
