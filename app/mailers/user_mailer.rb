# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: User::MAILER_FROM_EMAIL

  def confirmation(user, confirmation_token)
    @user = user
    @confirmation_token = confirmation_token

    mail to: @user.email, subject: 'Confirmation Instructions',
         locals: { user: @user, confirmation_token: @confirmation_token }
  end
end
