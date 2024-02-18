class CustomerItemsController < ApplicationController
  def create
    item = Item.find(params[:item_id])
    customer = Customer.find(params[:id])
    CustomerItem.create(customer_id: customer.id, item_id: item.id)
    redirect_to "/customers/#{customer.id}"
  end
end
