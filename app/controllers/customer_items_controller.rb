class CustomerItemsController < ApplicationController
  def create
   CustomerItem.create(item_id: params[:item], customer_id: params[:id])
   redirect_to "/customers/#{params[:id]}"
  end

end