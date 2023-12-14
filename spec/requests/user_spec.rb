# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include ControllerHelper
  describe 'GET #index' do
    let(:user) { build(:user) }
    it 'should return all users' do
      user_login(user)
      get users_path
      expect(response).to have_http_status(:ok)
    end
  end
  describe 'GET #show' do
    it 'should return one user' do
    end
  end
  describe 'POST create' do
    it 'should create a new user' do
    end
  end
  describe 'PATCH/PUT #update' do
    it 'should update a user' do
    end
  end
  describe 'DELETE #destroy' do
    it 'should delete a user' do
    end
  end
end
