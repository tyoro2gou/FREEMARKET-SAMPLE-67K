class AddressesController < ApplicationController
  def new
  end

  def create
    Address.create(address_params)
  end

  private

  def address_params
    params.require(:address).permit(:postal_code, :prefectures, :municipalities, :address, :building).merge(user_id: user.id)
  end
end
