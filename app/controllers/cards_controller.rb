class CardsController < ApplicationController

  require "payjp"

  def index
  end

  def show
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = "sk_test_0e2eb234eabf724bfaa4e676"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
end

def pay #クレジットカード登録
  Payjp.api_key = "sk_test_fc909327daf398b939d901a1"
  # ここでテスト鍵をセットしてあげる(環境変数にしても良い)
  if params['payjpToken'].blank?
  # paramsの中にjsで作った'payjpTokenが存在するか確かめる
    redirect_to action: "new"
  else
    customer = Payjp::Customer.create(
    card: params['payjpToken'],
    metadata: {user_id: current_user.id}
    )
   # ↑ここでjay.jpに保存
    @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
   # ここでdbに保存
    if @card.save
      redirect_to action: "show"
      flash[:notice] = 'クレジットカードの登録が完了しました'
    else
      redirect_to action: "pay"
      flash[:alert] = 'クレジットカード登録に失敗しました'
    end
  end
end
  def delete #PayjpとCardデータベースを削除します
    card = Card.where(user_id: current_user.id).first
    if card.blank?
    else
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(card.customer_id)
      customer.delete
      card.delete
    end
      redirect_to action: "new"
  end
  def show
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = "sk_test_fc909327daf398b939d901a1"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
end
end

  def create
  end

  

