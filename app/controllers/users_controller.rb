class UsersController < ApplicationController
  # before_action :move_to_show, only: :destroy
  def show
  end

  def logoutpage
  end

  def new
    @user = User.new
    @user.build_address
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:nickname, :family_name, :last_name, :family_name_kana, :last_name_kana, :birthday_info, :phone_number, address_attributes:[:id, :postal_code, :prefecture, :municipality, :address, :building])
  end

 
end
