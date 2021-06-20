require 'rails_helper'

RSpec.describe User, type: :model do
  context "全カラムの値を指定しているとき" do
    let(:user) { create(:user) }

    it "userのレコードが作成される" do
      expect(user).to be_valid
    end
  end

  context "emailを指定していないとき" do
    let(:user) { build(:user, email: nil) }

    it "エラーになる" do
      user.valid?
      expect(user.errors.messages[:email]).to include "can't be blank"
    end
  end

  context "passwordを指定していないとき" do
    let(:user) { build(:user, password: nil) }

    it "エラーになる" do
      user.valid?
      expect(user.errors.messages[:password]).to include "can't be blank"
    end
  end

  context "nameを指定していないとき" do
    let(:user) { build(:user, name: nil) }

    it "エラーになる" do
      user.valid?
      expect(user.errors.messages[:name]).to include "can't be blank"
    end
  end

  context "nicknameを指定していないとき" do
    let(:user) { build(:user, nickname: nil) }

    it "エラーになる" do
      user.valid?
      expect(user.errors.messages[:nickname]).to include "can't be blank"
    end
  end

  describe "validates uniqueness" do
    context "保存されたメールアドレスが指定されたとき" do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, email: user1.email) }

      it "エラーになる" do
        user2.valid?
        expect(user2.errors.messages[:email]).to include "has already been taken"
      end
    end
  end
end