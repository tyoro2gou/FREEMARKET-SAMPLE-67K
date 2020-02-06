class TopController < ApplicationController
  def index
    @items = Item.all.order("created_at DESC").limit(3)
    @images = Image.where(item_id: @items.ids)
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
