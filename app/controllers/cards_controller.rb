# class CardsController < ApplicationController
#   require "payjp"

#   def new
#   end

#   def create
#     if params['payjp-token'].blank?
#       redirect_to action: "index", id: current_user.id
#     else
#       customer = Payjp::Customer.create(
#       email: current_user.email,
#       card: params['payjp-token'],
#       metadata: {user_id: current_user.id}
#       )
#       @card = Cards.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
#       if @card.save!
#         redirect_to action: "show"
#       else
#         redirect_to action: "new", id: current_user.id
#       end
#     end
#   end

#   def delete
#     card = current_user.credit_cards.first
#     if card.present?
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       customer.delete
#       card.delete
#     end
#       redirect_to action: "confirmation", id: current_user.id
#   end

#   def show
#     card = current_user.cards.first
#     if card.present?
#       customer = Payjp::Customer.retrieve(card.customer_id)
#       @default_card_information = customer.cards.retrieve(card.card_id)
#     else
#       redirect_to action: "index", id: current_user.id
#     end
#   end
#   def index
#       card = current_user.cards
#       redirect_to action: "show" if card.exists?
#   end
#   private

#   def get_payjp_info
#     if Rails.env == 'development'
#       Payjp.api_key = ENV["pk_test_8a02eb526da8e8fce8bd4e8c"]
#     else
#       Payjp.api_key = Rails.application.credentials.payjp[:PAYJP_PRIVATE_KEY]
#     end
#   end
# end

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
      redirect_to action: "index"
    
    else
       customer = Payjp::Customer.create(
        # email: current_user.email,
        card: params['payjp-token'], 
       )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "new"
      else
        redirect_to action: "create"
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
