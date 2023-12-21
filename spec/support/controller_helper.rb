# frozen_string_literal: true

module ControllerHelper
  def create_auth_header(user)
    encoding = 'HS256'
    { 'Authorization' => "Bearer #{JWT.encode({ user_id: user.id }, Rails.application.credentials[Rails.env].json_web_token_secret,
                                              encoding)}" }
  end

  def find_mail_to(email)
    ActionMailer::Base.deliveries.find { |mail| mail.to.include?(email) }
  end
end
