# frozen_string_literal: true

class ApiController < ActionController::API
  include Pundit::Authorization
  include Authenticatable

  before_action :authorized
  before_action :user_confirmed

  rescue_from JWT::DecodeError, with: :handle_jwt_invalid
  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized
end
