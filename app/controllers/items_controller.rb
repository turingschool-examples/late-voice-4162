class ItemsController < ApplicationController
  def index
    @items = Item.includes(:supermarket).all
    # I used .includes to here for efficiency because we need to retrieve all items from the database along with their associated supermarket records in one line.
  end
end