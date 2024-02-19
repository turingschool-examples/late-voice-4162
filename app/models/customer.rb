class Customer < ApplicationRecord
    belongs_to :supermarket
    has_many :customer_items
    has_many :items, through: :customer_items

    def add_items(item_id)
        @customer = Customer.find(params[:id])
        @item = Item.find(params[:item_id])

        @customer.items << @item

        redirect_to customer_path(@customer)
    end
end
