class ApplicationController < ActionController::API
  include DeviseTokenAuth::Concerns::SetUserByToken

  protected

  def render_success(response_data = [])
    render json: {
      status: 'success',
      data: response_data
    }
  end

  def render_error(status, message)
    response = {
      status: 'error',
      errors: [message]
    }

    render json: response, status: status
  end
end
