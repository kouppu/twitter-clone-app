require 'rails_helper'

RSpec.describe Tweet, type: :model do
  context '全カラムの値を指定しているとき' do
    let(:tweet) { build_stubbed(:tweet) }

    it '有効である' do
      expect(tweet).to be_valid
    end
  end

  describe '#user_id' do
    context 'nilのとき' do
      let(:tweet) { build_stubbed(:tweet, user_id: nil) }
      it 'エラーになる' do
        expect(tweet).to_not be_valid
      end
    end
  end

  describe '#content' do
    let(:tweet) { build_stubbed(:tweet, content: content) }
    context 'nilなら' do
      let(:content) { nil }
      it 'エラーになる' do
        expect(tweet).to_not be_valid
      end
    end

    context '140文字以上なら' do
      let(:content) { 'a' * 141 }
      it 'エラーになる' do
        expect(tweet).to_not be_valid
      end
    end
  end

  describe 'DBから取得時' do
    context '通常' do
      let(:second_tweet) { create(:second_tweet) }
      let(:most_recent_tweet) { create(:most_recent_tweet) }
      it '登録日降順で取得できる' do
        expect(most_recent_tweet).to eq Tweet.first
      end
    end
  end
end
