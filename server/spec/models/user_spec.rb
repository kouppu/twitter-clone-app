require 'rails_helper'

RSpec.describe User, type: :model do
  context '全カラムの値を指定しているとき' do
    let(:user) { create(:user) }

    it '有効である' do
      expect(user).to be_valid
    end
  end

  describe '#email' do
    context 'nilのとき' do
      let(:user) { build(:user, email: nil) }

      it 'エラーになる' do
        user.valid?
        expect(user).to_not be_valid
      end
    end
  end

  describe '#password' do
    context 'nilのとき' do
      let(:user) { build(:user, password: nil) }

      it 'エラーになる' do
        user.valid?
        expect(user).to_not be_valid
      end
    end
  end

  describe '#name' do
    context 'nilのとき' do
      let(:user) { build(:user, name: nil) }

      it 'エラーになる' do
        user.valid?
        expect(user).to_not be_valid
      end
    end
  end

  describe '#nickname' do
    context 'nilのとき' do
      let(:user) { build(:user, nickname: nil) }

      it 'エラーになる' do
        user.valid?
        expect(user).to_not be_valid
      end
    end
  end

  describe 'validates uniqueness' do
    context '保存されたメールアドレスが指定されたとき' do
      let(:user1) { create(:user) }
      let(:user2) { build(:user, email: user1.email) }

      it 'エラーになる' do
        user2.valid?
        expect(user2.errors.messages[:email]).to include "has already been taken"
      end
    end
  end

  describe '#delete' do
    context '紐づくツイートがある状態で削除されたとき' do
      let(:user) { create(:user) }
      let(:tweet) { create(:tweet, user_id: user.id) }

      it '紐づくツイートも削除される' do
        user.destroy
        expect(Tweet.count).to eq 0
      end
    end
  end
end
