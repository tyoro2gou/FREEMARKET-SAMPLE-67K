class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.save
    redirect_to user_path(current_user.id)
  end

  def edit
    @address = Address.find_by(user_id: current_user.id)
  end

  def update
    @address = Address.find_by(user_id: current_user.id)
    @address.update(address_params)
    redirect_to user_path(current_user.id)
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :municipalities, :address, :building).merge(user_id: current_user.id)
  end
  
end
