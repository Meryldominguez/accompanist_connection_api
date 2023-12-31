# frozen_string_literal: true

class UsersController < ApiController
  rescue_from ActiveRecord::RecordInvalid, with: :handle_invalid_record

  skip_before_action :authorized, :user_confirmed, only: [:create]
  before_action :set_user, only: %i[show update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    render 'show', locals: { user: @user }
  end

  # POST /users
  def create
    user = User.create!(user_params)
    user.send_confirmation_email!
    @token = encode_token(user_id: user.id)
    render json: {
      user:,
      token: @token
    }, status: :created
  end

  # PATCH/PUT /users/1
  def update
    authorize @user
    @user.update!(user_params)
    render json: @user
  end

  # DELETE /users/1
  def destroy
    authorize @user
    @user.destroy!
    render json: '', status: :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.permit(:first_name, :last_name, :email, :password)
  end

  def handle_invalid_record(err)
    render json: { errors: err.record.errors.full_messages }, status: :unprocessable_entity
  end
end
