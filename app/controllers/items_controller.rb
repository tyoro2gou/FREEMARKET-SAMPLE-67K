class ItemsController < ApplicationController
  require 'payjp'
  before_action :move_to_top

    def index
      card = Card.where(user_id: current_user.id).first
      #Cardテーブルは前回記事で作成、テーブルからpayjpの顧客IDを検索
      if card.blank?
        #登録された情報がない場合にカード登録画面に移動
        redirect_to controller: "card", action: "new"
      else
        Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
        #保管した顧客IDでpayjpから情報取得
        customer = Payjp::Customer.retrieve(card.customer_id)
        #保管したカードIDでpayjpから情報取得、カード情報表示のためインスタンス変数に代入
        @default_card_information = customer.cards.retrieve(card.card_id)
      end
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

  

  def pay
    @item = Item.find(params[:id])
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    charge = Payjp::Charge.create(
    amount: @item.price,
    card: params['payjp-token'],
    currency: 'jpy'
    )
    redirect_to root_path 
  end


  private

  def move_to_top
    redirect_to root_path unless user_signed_in?
  end

  def item_params
    params.require(:item).permit(:name, :text, :description, :category_id, :status_id, :postage_id, :region_id, :shipping_date_id, :price, images_attributes: [:image]).merge(saler_id: current_user.id)
  end
end
