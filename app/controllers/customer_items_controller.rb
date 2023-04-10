class CustomerItemsController < ApplicationController

  def create
    CustomerItem.create(customer_id: params[:customer], item_id: params[:item_id])
    redirect_to "/customers/#{params[:customer]}"
  end
end