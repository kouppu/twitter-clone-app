class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  # 正常レスポンス
  #
  # @param array
  def render_success(response_data = [])
    render json: {
      status: 'success',
      data: response_data
    }
  end

  # 異常レスポンスを返す
  #
  # @param string ステータスコード
  # @param string
  def render_error(status, message)
    response = {
      status: 'error',
      errors: [message]
    }

    render json: response, status: status
  end
end
