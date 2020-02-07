require 'rails_helper'
describe Address do
  describe '#create' do
    # 必須項目が全てあれば登録できること
    it "is valid with a postal_code, prefecture, municipalities, address" do
      user = create(:user)
      address = build(:address, user_id: user.id)
      expect(address).to be_valid
    end

    # postal_codeがないと登録できないこと
    it "is invalid without a postal_code" do
      address = build(:address, postal_code: "")
      address.valid?
      expect(address.errors[:postal_code]).to include("can't be blank")
    end

    # prefecturesがないと登録できないこと
    it "is invalid without prefectures" do
      address = build(:address, prefectures: "")
      address.valid?
      expect(address.errors[:prefectures]).to include("can't be blank")
    end

    # municipalitiesがないと登録できないこと
    it "is invalid without municipalities" do
      address = build(:address, municipalities: "")
      address.valid?
      expect(address.errors[:municipalities]).to include("can't be blank")
    end

    # addressがないと登録できないこと
    it "is invalid without a address" do
      address = build(:address, address: "")
      address.valid?
      expect(address.errors[:address]).to include("can't be blank")
    end

  end
end