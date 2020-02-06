class CardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def new 
    card = Card.where(user_id: current_user.id).first
    redirect_to action: "index" if card.present?
  end

  def create 
    Payjp.api_key = 'sk_test_fc909327daf398b939d901a1'

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
        redirect_to cards_path
      end
    end
  end

  def show 
    if @card.present?
      Payjp.api_key = "sk_test_fc909327daf398b939d901a1"
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_information = customer.cards.retrieve(@card.card_id)
    end
  end


  private

  def set_card
    # @card = Card.where(user_id: current_user.id).first if Card.where(user_id: current_user.id).present?
  end
end
