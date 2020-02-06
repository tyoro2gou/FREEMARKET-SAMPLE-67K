class UsersController < ApplicationController
  before_action :move_to_show, only: :destroy
  def show
  end

  def before_logout
  end

  # Payjp.api_key = PAYJP_SECRET_KEY = 'sk_test_fc909327daf398b939d901a1'
  # customer = Payjp::Customer.create(card: params[:payjp_token])
 
end
