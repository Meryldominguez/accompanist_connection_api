# frozen_string_literal: true

module ControllerHelper
  def user_login(user)
    secret = Rails.application.credentials.json_web_token_secret

    encoding = 'HS512'

    @request.headers['Authorization'] =
      JWT.encode({ user_id: user.id }, secret, encoding)
  end
end
