require 'rails_helper'
describe Image do
  describe '#create' do
    # 複数投稿ができること
    it "is valid with multiple images" do
      user = create(:user)
      category = create(:category)
      item = FactoryBot.build(:item, saler_id: user.id, category_id: category.id) do |i|
        i.images.build(FactoryBot.attributes_for(:image))
      end
      expect(image).to be_valid
    end

    # imageがないと登録できないこと
    it "is invalid without a image" do
      user = create(:user)
      category = create(:category)
      item = create(:item, saler_id: user.id, category_id: category.id)
      image = build(:image, image: "", item_id: item.id)
      image.valid?
      expect(image.errors[:image]).to include("can't be blank")
    end

  end
end