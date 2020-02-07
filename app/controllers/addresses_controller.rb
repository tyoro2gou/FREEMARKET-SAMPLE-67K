class AddressesController < ApplicationController
  before_action :set_current_address, only: [:edit, :update]

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to user_path(current_user.id)
  end

  def edit
  end

  def update
    if @address.update(address_params)
      redirect_to user_path(current_user.id)
    else
      redirect_to edit_address_path(current_user.id)
    end
  end

  private

  def set_current_address
    @address = Address.find_by(user_id: current_user.id)
  end

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :municipalities, :address, :building).merge(user_id: current_user.id)
  end
  
end
