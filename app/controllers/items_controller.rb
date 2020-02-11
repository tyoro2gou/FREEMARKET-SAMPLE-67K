class ItemsController < ApplicationController
  before_action :move_to_top, except: :show

  def index
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to user_path(current_user.id)
    else
      render :new
    end
  end

  def show
    @item = Item.includes(:saler).find(params[:id])
    @images = @item.images
  end

  def saling_show
    @user = User.find(current_user.id)
    @items = Item.where(saler_id: current_user.id)
    @images = Image.where(item_id: @items.ids)
  end

  def saled_show
    @user = User.find(current_user.id)
    @items = Item.where(buyer_id: current_user.id)
    @images = Image.where(item_id: @items.ids)
  end


  private
   def move_to_top
     redirect_to root_path unless user_signed_in?
   end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price).merge(saler_id: current_user.id)
  end
end
