# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authorized
  rescue_from JWT::DecodeError, with: :error_render_method

  def encode_token(payload)
    JWT.encode(payload, Rails.application.credentials.json_web_token_secret)
  end

  def decoded_token
    header = request.headers['Authorization']
    return unless header

    token = header.split(' ')[1]
    JWT.decode(token, Rails.application.credentials.json_web_token_secret, true, algorithm: 'HS256')
  end

  def current_user
    return unless request.headers['Authorization']

    user_id = decoded_token[0]['user_id']
    @user = User.find_by(id: user_id)
  end

  def authorized
    return unless current_user.nil?

    render json: { message: 'Please log in' }, status: :unauthorized
  end

  private

  def error_render_method
    render json: { message: 'JWT token is invalid or expired' }, status: :unauthorized
  end
end
