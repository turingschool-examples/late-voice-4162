class CustomersController < ApplicationController
  def show 
    @customer = Customer.find(params[:id])
    @items = @customer.items.includes(:supermarket)
    @customer_item = @customer.customer_items.new  # Initialize a new customer item

    if params[:customer_item].present?
      @customer_item = @customer.customer_items.new(customer_item_params)
      if @customer_item.save
        redirect_to "/customers/:id", notice: "Item added successfully"
      else
        flash.now[:alert] = "Failed to add item"
      end
    end
  end

  private

  def customer_item_params
    params.require(:customer_item).permit(:item_id)
  end 
end