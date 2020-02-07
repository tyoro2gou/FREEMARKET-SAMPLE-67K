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
  end

  def update
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :municipalities, :address, :building).merge(user_id: current_user.id)
  end
  
end
