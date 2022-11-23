class ItemsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :user_not_found

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
   
    return render json: items, include: :user
  end


  def show 
    item = Item.find(params[:id])
    render json: item
  end

  def create 
user = User.find(params[:user_id])
item = user.items.create(items_params)
render json: item, status: :created
  end

  private
  def items_params
    params.permit(:name, :description, :price)
  end

  def user_not_found
    render json: {error: 'Could not find User with #{params[:user_id]}'}, status: :not_found
  end
end
