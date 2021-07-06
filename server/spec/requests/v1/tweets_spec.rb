require 'rails_helper'

RSpec.describe "V1::Tweets", type: :request do
  describe 'GET /v1/tweets' do
    before do
      create_list(:tweet, 30)
    end

    context '未ログイン時' do
      it 'ツイートを取得できないこと' do
        get '/v1/tweets'
        expect(response).to have_http_status(401)
      end
    end

    context 'ログイン時' do
      let(:user) { create(:user) }
      it 'ツイートを取得できる' do
        auth_tokens = sign_in(user)
        get '/v1/tweets', headers: auth_tokens
        expect(response).to have_http_status(200)
      end
    end

    context 'param[:page]指定時' do
      let(:user) { create(:user) }

      it '返される数は10件以下' do
        auth_tokens = sign_in(user)
        get '/v1/tweets', params: { page: 1 }, headers: auth_tokens
        res = JSON.parse(response.body)
        expect(res['data'].count <= 10).to eq true
      end

      it '存在しないページなら空配列を返す' do
        auth_tokens = sign_in(user)
        get '/v1/tweets', params: { page: 5 }, headers: auth_tokens
        res = JSON.parse(response.body)
        expect(res['data']).to eq []
      end
    end
  end

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
        expect(response).to have_http_status(200)
      end
    end

    context '違うユーザーのツイートを削除しようとしたら' do
      let(:other) { create(:user) }
      it '削除できない' do
        auth_tokens = sign_in(other)
        delete "/v1/tweets/#{tweet.id}", headers: auth_tokens
        expect(response).to have_http_status(404)
      end
    end
  end
end
