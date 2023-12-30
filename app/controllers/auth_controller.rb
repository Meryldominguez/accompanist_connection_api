# frozen_string_literal: true

class AuthController < ApiController
  skip_before_action :authorized, only: %i[login]
  skip_before_action :user_confirmed, only: %i[login index]
  rescue_from ActiveRecord::RecordNotFound, with: :handle_record_not_found
  rescue_from ActionController::ParameterMissing, with: :handle_parameter_missing

  def index
    @current_user = User.find(decoded_token[0]['user_id'])
    raise JWT::DecodeError unless @current_user

    render json: {
      user: UserSerializer.new(@current_user)
    }, status: :accepted
  end

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

  def index_params
    params.require(:auth).permit(:token).tap do |p|
      p.require(:token)
    end
  end

  def handle_record_not_found(_err)
    render json: { message: "User doesn't exist" }, status: :unauthorized
  end

  def handle_parameter_missing(err)
    render json: { message: 'Missing Parameter', error: err }, status: :bad_request
  end
end
