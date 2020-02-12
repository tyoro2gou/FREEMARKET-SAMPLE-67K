class ItemsController < ApplicationController
  require 'payjp'
  before_action :move_to_top
  before_action :move_to_top, except: :show
  before_action :set_item, only: [:before_buy, :buy]



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

  def index
  end

  def pay
    @item = Item.find(params[:id])
    card = Card.where(user_id: current_user.id).first
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    Payjp::Charge.create(
    amount: @item.price,
    customer: card.customer_id,
    card: params['payjp-token'],
    currency:'jpy', 
  )
  redirect_to root_path
  end

  


  private

  def move_to_top
    redirect_to root_path unless user_signed_in?

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :text, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image]).merge(saler_id: current_user.id)
  end
end
end
