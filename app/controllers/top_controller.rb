class TopController < ApplicationController
  def index
    @items = Item.where(buyer_id: nil).order("created_at DESC").limit(1)
  end

  def new
    @image = TestImage.new
  end

  def create
    TestImage.create(image_params)
    redirect_to new_top_path
  end

  private
  def image_params
    params.permit(:image)
  end
end
