class CustomersController < ApplicationController
    def show
        @customer = Customer.find(params[:id])
        @item_id = params[:item_id]

        add_item(@item_id)
    end
end
