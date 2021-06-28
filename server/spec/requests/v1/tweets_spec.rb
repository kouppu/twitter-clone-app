require 'rails_helper'

RSpec.describe "V1::Tweets", type: :request do
  describe 'POST /v1/tweets' do
    valid_params = { content: 'text' }

    context '未ログイン時' do
      it 'ツイートできない' do
        post '/v1/tweets', params: valid_params
        expect(response).to have_http_status(401)
      end
    end

    context 'ログイン時' do
      let(:user) { create(:user) }
      it 'ツイートできる' do
        auth_tokens = sign_in(user)
        post '/v1/tweets', params: valid_params, headers: auth_tokens
        res = JSON.parse(response.body)
        expect(res['status']).to eq('success')
        expect(res['data']['content']).to eq(valid_params[:content])
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'DELETE /v1/tweets/:id' do
    let(:user) { create(:user) }
    let(:tweet) { create(:tweet, user_id: user.id) }

    context '未ログイン時' do
      it '削除できない' do
        delete "/v1/tweets/#{tweet.id}"
        expect(response).to have_http_status(401)
      end
    end

    context 'ログイン時' do
      it '削除できる' do
        auth_tokens = sign_in(user)
        delete "/v1/tweets/#{tweet.id}", headers: auth_tokens
        puts response.status
        expect(response).to have_http_status(200)
      end
    end
  end
end
