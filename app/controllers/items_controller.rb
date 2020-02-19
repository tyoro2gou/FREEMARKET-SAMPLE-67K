class ItemsController < ApplicationController
  require 'payjp'
  before_action :move_to_top
  before_action :move_to_top, except: :show
  before_action :set_item, only: [:before_buy, :pay, :edit, :update, :destroy]
  
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
      render new_item_path
    end
  end
  
  def edit
    @images = @item.images
    # binding.pry
    @selected_parent_category = Category.find(@item.category.ancestry)
    @selected_child_category = Category.find(@item.category.id)
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
  end

  def saled_show
    @user = User.find(current_user.id)
    @items = Item.where(buyer_id: current_user.id)
  end


  def before_buy
    @user = User.find(current_user.id)
    if @user.cards.exists?
      @image = Image.find_by(item_id: @item.id)
      @address = Address.find_by(user_id: current_user.id)
      @card = Card.find_by(user_id: current_user.id)
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
    else
      redirect_to new_card_path
    end
  end


  def pay
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    card: params['payjp-token'],
    currency:'jpy', 
    )
    @item.buyer_id = current_user.id
    @item.save
    redirect_to root_path
  end

  def destroy
   if @item.destroy
      redirect_to root_path
    else
      render :edit
    end
  end


  private

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image, :image_cache ]).merge(saler_id: current_user.id)
  end

  def item_params_update
    params.require(:item).permit(:name, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image, :_destroy, :id]).merge(saler_id: current_user.id)
  end


end