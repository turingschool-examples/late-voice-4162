class CustomersController < ApplicationController
    def show
        @customer = Customer.find(params[:id])
    
        add_item(@customer.item.id)
        
        redirect_to "/customers/:id"
    end
end
