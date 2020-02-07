require 'rails_helper'
describe User do
  describe '#create' do
    # 必須項目が全てあれば登録できること
    it "is valid with a nickname, email, password, password_confirmation, family_name, last_name, family_name_kana, last_name_kana, birthday_info" do
      user = build(:user)
      expect(user).to be_valid
    end

    # nicknameがないと登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
    end

    # emailがないと登録できないこと
    it "is invalid without an email" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("can't be blank")
    end

    # emailが重複してると登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user)
      another_user.valid?
      expect(another_user.errors[:email]).to include("has already been taken")
    end

    # emailに@とドメインがないと登録できないこと
    it "is invalid with an email address" do
      user = build(:user, email: "tanaka@aya")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end

    # passwordがないと登録できないこと
    it "is invalid without a password" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    # passwordが存在してもpassword_confirmationが空では登録できないこと
    it "is invalid without a password_confirmation although with a password" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    # passwordが7文字以上であれば登録できること
    it "is valid with a password that has more than 7 characters " do
      user = build(:user, password: "0000000", password_confirmation: "0000000")
      user.valid?
      expect(user).to be_valid
    end

    # passwordが6文字以下であれば登録できないこと
    it "is invalid with a password that has less than 6 characters " do
      user = build(:user, password: "000000", password_confirmation: "000000")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 7 characters)")
    end

    #family_nameがないと登録できないこと
    it "is invalid without a family_name" do
      user = build(:user, family_name: "")
      user.valid?
      expect(user.errors[:family_name]).to include("can't be blank")
    end

    #last_nameがないと登録できないこと
    it "is invalid without a last_name" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("can't be blank")
    end

    #family_name_kanaがないと登録できないこと
    it "is invalid without a family_name_kana" do
      user = build(:user, family_name_kana: "")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("can't be blank")
    end

    #last_name_kanaがないと登録できないこと
    it "is invalid without a last_name_kana" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("can't be blank")
    end

    #family_nameが半角だと登録できないこと
    it "is invalid with a family_name that has halfwidth charactor" do
      user = build(:user, family_name: "yamada")
      user.valid?
      expect(user.errors[:family_name]).to include("is invalid")
    end

    #last_nameが半角だと登録できないこと
    it "is invalid with a last_name that has halfwidth charactor" do
      user = build(:user, last_name: "aya")
      user.valid?
      expect(user.errors[:last_name]).to include("is invalid")
    end

    #family_name_kanaが半角だと登録できないこと
    it "is invalid with a family_name_kana that has halfwidth charactor" do
      user = build(:user, family_name_kana: "yamada")
      user.valid?
      expect(user.errors[:family_name_kana]).to include("is invalid")
    end

    #last_name_kanaが半角だと登録できないこと
    it "is invalid with a last_name_kana that has halfwidth charactor" do
      user = build(:user, last_name_kana: "aya")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("is invalid")
    end

    # birthday_infoがないと登録できないこと
    it "is invalid without a birthday_info" do
      user = build(:user, birthday_info: "")
      user.valid?
      expect(user.errors[:birthday_info]).to include("can't be blank")
    end


  end
  
end