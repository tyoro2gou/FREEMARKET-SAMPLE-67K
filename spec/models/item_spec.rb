require 'rails_helper'
describe Item do
  describe '#create' do
    # 必須項目が全てあれば登録できること
    it "is valid with a name, description, status_id, postage_id, region_id, shipping_date_id, price" do
      user = create(:user)
      category = create(:category)
      item = build(:item, saler_id: user.id, category_id: category.id)
      expect(item).to be_valid
    end

    # nameがないと登録できないこと
    it "is invalid without a name" do
      item = build(:item, name: "")
      item.valid?
      expect(item.errors[:name]).to include("can't be blank")
    end

    # descriptionがないと登録できないこと
    it "is invalid without a description" do
      item = build(:item, description: "")
      item.valid?
      expect(item.errors[:description]).to include("can't be blank")
    end

    # status_idがないと登録できないこと
    it "is invalid without a status_id" do
      item = build(:item, status_id: "")
      item.valid?
      expect(item.errors[:status_id]).to include("can't be blank")
    end

    # postage_idがないと登録できないこと
    it "is invalid without a postage_id" do
      item = build(:item, postage_id: "")
      item.valid?
      expect(item.errors[:postage_id]).to include("can't be blank")
    end

    # region_idがないと登録できないこと
    it "is invalid without a region_id" do
      item = build(:item, region_id: "")
      item.valid?
      expect(item.errors[:region_id]).to include("can't be blank")
    end

    # shipping_date_idがないと登録できないこと
    it "is invalid without a shipping_date_id" do
      item = build(:item, shipping_date_id: "")
      item.valid?
      expect(item.errors[:shipping_date_id]).to include("can't be blank")
    end

    # priceがないと登録できないこと
    it "is invalid without a price" do
      item = build(:item, price: "")
      item.valid?
      expect(item.errors[:price]).to include("can't be blank")
    end

  end
end