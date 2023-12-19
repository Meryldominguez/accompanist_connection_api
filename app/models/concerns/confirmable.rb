# frozen_string_literal: true

module Confirmable
  extend ActiveSupport::Concern

  included do
    CONFIRMATION_TOKEN_EXPIRATION = 10.minutes.freeze

    def confirm!
      update_columns(confirmed_at: Time.current)
    end

    def confirmed?
      confirmed_at.present?
    end

    def generate_confirmation_token
      signed_id expires_in: CONFIRMATION_TOKEN_EXPIRATION, purpose: :confirm_email
    end

    def unconfirmed?
      !confirmed?
    end

    def send_confirmation_email!
      confirmation_token = generate_confirmation_token
      UserMailer.confirmation(self, confirmation_token).deliver_now
    end
  end
end
