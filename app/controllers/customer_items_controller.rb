class CustomerItemsController < ApplicationController
  def create
    customer_item = CustomerItem.new(customer_id: params[:customer_id], item_id: params[:item_id])
    customer_item.save

    redirect_to customer_path(params[:customer_id])
  end
end
