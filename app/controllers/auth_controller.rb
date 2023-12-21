# frozen_string_literal: true

class AuthController < ApiController
  skip_before_action :authorized, only: [:login]
  skip_before_action :user_confirmed, only: [:login]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  def login
    @user = User.find_by!(email: login_params[:email])
    if @user.authenticate(login_params[:password])
      @token = encode_token(user_id: @user.id)
      render json: {
        user: UserSerializer.new(@user),
        token: @token
      }, status: :accepted
    else
      render json: { message: 'Incorrect password' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.require(:auth).permit(:password, :email).tap do |p|
      p.require(:password)
      p.require(:email)
    end
  end

  def handle_record_not_found(_err)
    render json: { message: "User doesn't exist" }, status: :unauthorized
  end

  def handle_parameter_missing(err)
    render json: { message: 'Please send both email and password', error: err }, status: :bad_request
  end
end
