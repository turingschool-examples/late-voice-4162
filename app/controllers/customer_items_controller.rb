class CustomerItemsController < ApplicationController

  def create
    customer_item = CustomerItem.new(customer_items_params)
    customer_item.save
    # require 'pry' ; binding.pry
    redirect_to "/customers/#{params[:customer_id]}"
  end

  private
    def customer_items_params
      params.permit(:customer_id, :item_id)
    end
end