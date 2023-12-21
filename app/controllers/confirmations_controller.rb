# frozen_string_literal: true

class ConfirmationsController < ApiController
  skip_before_action :user_confirmed, only: %i[resend confirm]

  def resend
    @user = User.find_by(email: resend_params['email'])
    authorize @user, policy_class: ConfirmationPolicy unless @user.nil?
    if @user.present? && @user.unconfirmed?
      @user.send_confirmation_email!
      render json: { message: 'Email with confirmation has been resent' }, status: :ok
    else
      render json: { message: 'We could not find a user with that email or that email has already been confirmed' },
             status: :bad_request
    end
  end

  def confirm
    @user = User.find_signed(confirm_params['confirmation_token'], purpose: :confirm_email)
    authorize @user, policy_class: ConfirmationPolicy unless @user.nil?
    if @user.present? && @user.unconfirmed?
      @user.confirm!
      render json: { message: 'Your account has been confirmed' }, status: :ok
    else
      render json: { message: 'We could not find a user with that email or that email has already been confirmed' },
             status: :bad_request
    end
  end

  private

  def resend_params
    params.require(:confirmation).permit(:email)
  end

  def confirm_params
    params.require(:confirmation).permit(:confirmation_token)
  end
end
