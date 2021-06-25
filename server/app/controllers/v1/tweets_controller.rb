class V1::TweetsController < ApplicationController
  before_action :authenticate_v1_user!, only: %i[create destroy]
  before_action :correct_user, only: :destroy

  def create
    @tweet = current_v1_user.tweets.build(tweet_params)
    if @tweet.save
      render_success(@tweet)
    else
      render_error(400, 'Not Created')
    end
  end

  def destroy
    @tweet.destroy
    render_success
  end

  private

  def tweet_params
    params.require(:tweet).permit(:content)
  end

  def correct_user
    @tweet = current_v1_user.tweets.find_by(id: params[:id])
    render_error(404, 'Not Found') if @tweet.nil?
  end
end
