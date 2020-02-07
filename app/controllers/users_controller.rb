class UsersController < ApplicationController
  before_action :move_to_show, only: :destroy
  def show
    @user = User.find(current_user.id)
    @address = Address.find_by(user_id: current_user.id)
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to edit_user_path(current_user.id)
    end
  end


  def before_logout
  end


  private

  def user_params
    params.require(:user).permit(:nickname, :email, :family_name, :last_name, :family_name_kana, :last_name_kana, :phone_number)
  end


  # Payjp.api_key = PAYJP_SECRET_KEY = 'sk_test_fc909327daf398b939d901a1'
  # customer = Payjp::Customer.create(card: params[:payjp_token])

end
