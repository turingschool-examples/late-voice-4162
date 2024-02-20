class CustomerItemsController < ApplicationController
  def create
    customer_item = CustomerItem.new(customer_id: params[:id], item_id: params[:item_id])
    customer_item.save

    redirect_to "/customers/#{params[:id]}"
  end
end