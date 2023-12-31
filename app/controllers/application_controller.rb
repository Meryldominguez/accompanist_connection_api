# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  include Authenticatable

  rescue_from JWT::DecodeError, with: :handle_jwt_invalid
  rescue_from Pundit::NotAuthorizedError, with: :handle_unauthorized

  def index; end
end
