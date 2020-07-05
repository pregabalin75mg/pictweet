require 'rails_helper'
describe User do
  describe '#create' do
    it "全てが入力されていたら登録できること" do
      user = build(:user)
      expect(user).to be_valid
    end

    it "nameがない場合登録できないこと" do 
      user = build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("can't be blank")
      
    end

    it "mailがない場合は登録できないこと" do
      user = build(:user, email: "")
     user.valid?
     expect(user.errors[:email]).to include("can't be blank")
    end

    it "password なしでは登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("can't be blank")
    end

    it "password_confirmationなしでは登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it "７文字以上は登録できないこと" do
      user = build(:user, nickname: "kahjsgflakdjfghlakjdfglkajsglfa")
      user.valid?
      expect(user.errors[:nickname]).to include("is too long (maximum is 6 characters)")
    end

    it "重複したemailは登録できないこと" do
      user1 = create(:user, email: "sasa@sasasa")
      user2 = build(:user, email: "sasa@sasasa")
      user2.valid?
      expect(user2.errors[:email]).to include("has already been taken")
    end
  end
end
