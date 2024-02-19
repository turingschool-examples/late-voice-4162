class CustomersController < ApplicationController
  def show 
    @customer = Customer.find(params[:id])
    @items = @customer.items.includes(:supermarket)
  end
end