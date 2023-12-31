# frozen_string_literal: true

class ProfilesController < ApiController
  before_action :set_profile, only: %i[show update destroy]
  before_action :set_options, only: %i[show]

  # GET /profiles
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  def show
    render 'show', locals: { profile: @profile }
  end

  # POST /profiles
  def create
    @profile = Profile.new(profile_params)

    if @profile.save
      render json: @profile, status: :created, location: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /profiles/1
  def update
    if @profile.update(profile_params)
      render json: @profile
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /profiles/1
  def destroy
    @profile.destroy!
  end

  private

  def set_options
    @options = {}
    @options[:include] = params[:include].map(&:to_sym) unless params[:include].nil?
    p(@options)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def profile_params
    params.fetch(:profile, {})
  end
end
