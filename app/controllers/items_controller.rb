class ItemsController < ApplicationController
  before_action :move_to_top

  def index
  end

  def new
    @item = Item.new
    @images = @item.images.build
  end

  def children_category
    @children = Category.find(params[:parent_id]).children
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
  end

  def saling_show
    @user = User.find(current_user.id)
    @items = Item.where(saler_id: current_user.id, buyer_id: nil)
    @images = Image.where(item_id: @items.ids)
  end

  def saled_show
    @user = User.find(current_user.id)
    @items = Item.where(buyer_id: current_user.id)
    @images = Image.where(item_id: @items.ids)
  end


  def before_buy
    @item = Item.find(params[:id])
    @image = Image.find_by(item_id: @item.id)
    @address = Address.find_by(user_id: current_user.id)
    @cards = Card.where(user_id: current_user.id)
  end



  private
  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def item_params

    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image]).merge(saler_id: current_user.id)
  end
end
