# frozen_string_literal: true

module Authenticatable
  extend ActiveSupport::Concern

  included do
    def header_token
      header = request.headers['Authorization']
      return unless header

      header.split[1]
    end

    def encode_token(payload)
      JWT.encode(payload, Rails.application.credentials[Rails.env].json_web_token_secret)
    end

    def decoded_token
      token = header_token
      JWT.decode(token, Rails.application.credentials[Rails.env].json_web_token_secret, true, algorithm: 'HS256')
    end

    def current_user
      return unless request.headers['Authorization']

      user_id = decoded_token[0]['user_id']
      @current_user = User.find_by(id: user_id)
    end

    def authorized
      return unless current_user.nil?

      render json: { message: 'Please log in' }, status: :unauthorized
    end

    def user_confirmed
      return unless current_user.unconfirmed?

      render json: { message: 'Please confirm your email before continuing' }, status: :unauthorized
    end

    def handle_jwt_invalid
      render json: { message: 'JWT token is invalid or expired' }, status: :unauthorized
    end

    def handle_unauthorized
      render json: { message: 'You are not authorized to do this' }, status: :unauthorized
    end
  end
end
