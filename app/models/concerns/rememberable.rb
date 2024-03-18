# frozen_string_literal: true

module Rememberable
  extend ActiveSupport::Concern

  included do
    def admin_role
      user_roles.find_by(role_id: Role.admin.id)
    end

    def remember_me!
      admin_role.update(remember_token: SecureRandom.urlsafe_base64(15),
                        remember_token_expires_at: Time.now + Trestle.config.auth.remember.for)
    end

    def forget_me!
      admin_role.update(remember_token: nil, remember_token_expires_at: nil)
    end

    def remember_token_expired?
      admin_role.remember_token_expires_at.nil? || Time.now > admin_role.remember_token_expires_at
    end
  end

  class_methods do
    def authenticate_with_remember_token(token)
      user = find_by(remember_token: token)
      user if user && !user.remember_token_expired?
    end
  end
end
