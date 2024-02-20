class CustomersController < ApplicationController

    def show
        @customer = Customer.find(params[:id])
        if params[:item_id].present?
            @item = Item.find(params[:item_id])
            CustomerItem.create!(customer_id: @customer.id, item_id: @item.id)
        end
    end


end