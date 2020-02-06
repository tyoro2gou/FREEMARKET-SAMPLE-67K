class UsersController < ApplicationController
  # before_action :move_to_show, only: :destroy
  def show
    @user = User.find(current_user.id)
  end

  def before_logout
  end
 
end
