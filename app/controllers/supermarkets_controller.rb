class SupermarketsController < ApplicationController
  def show
    @market = Supermarket.find(params[:id])
  end
end