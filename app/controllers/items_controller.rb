class ItemsController < ApplicationController
  before_action :move_to_top, except: :show
  before_action :set_item, only: [:before_buy, :buy, :edit, :update, :destroy]
  
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
  
  def edit
    @images = @item.images
  end

  def update
    if @item.update(item_params_update)
      redirect_to user_path(current_user.id)
    else
      render :edit
    end
  end

  def show
    @item = Item.includes(:saler).find(params[:id])
    @images = @item.images
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
    @image = Image.find_by(item_id: @item.id)
    @address = Address.find_by(user_id: current_user.id)
    @card = Card.find_by(user_id: current_user.id)
    customer = Payjp::Customer.retrieve(@card.customer_id)
    @card_information = customer.cards.retrieve(@card.card_id)
  end

  def buy
    @item.buyer_id = current_user.id
    if @item.save
      redirect_to user_path
    else
      redirect_to item_path(@item.id)
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end



  private
   def move_to_top
     redirect_to root_path unless user_signed_in?
   end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image]).merge(saler_id: current_user.id)
  end

  def item_params_update
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image, :_destroy, :id]).merge(saler_id: current_user.id)
  end


end
