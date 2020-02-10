class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def new 
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def create 
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    if params['payjp-token'].blank?
      redirect_to new_card_path
    else
       customer = Payjp::Customer.create(
        card: params['payjp-token'], 
       )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to new_card_path
      else
        redirect_to card_path
      end
    end
  end


  def show 
    if @card.present?
      Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
    end
  end

  def destroy 
    Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy 
      redirect_to action: "index", notice: "削除しました"
    else 
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end


  private

  def set_card
    @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
