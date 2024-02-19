class CustomerItemsController < ApplicationController
   def create
      customer_item = CustomerItem.create(customer_id: params[:id], item_id: params[:item_id])
      redirect_to "/customers/#{params[:id]}"
   end
end