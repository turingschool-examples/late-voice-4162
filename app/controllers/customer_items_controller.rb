class CustomerItemsController < ApplicationController
    def create 
        @customer = Customer.find(params[:id])
        item_of_customer = Item.find_by(id: params[:item_id])
        CustomerItem.create(customer_id: @customer.id, item_id: item_of_customer.id)
        redirect_to "/customers/#{@customer.id}"
    end
end