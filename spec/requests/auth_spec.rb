# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Auths', type: :request do
  user_password = 'password'
  let(:user) { create(:user, password_digest: BCrypt::Password.create(user_password)) }
  describe 'POST auth/login' do
    context 'with valid email/password' do
      before do
        @params = { email: user.email, password: user_password }
        post login_url, params: @params, as: :json
      end
      it 'returns accepted' do
        assert_response :accepted
      end
      it 'returns a token' do
        expect(response.body).to include('token')
      end
      it 'returns valid user data' do
        expect(response.body).to include(user.first_name)
        expect(response.body).to include(user.last_name)
      end
    end
    context 'with wrong password' do
      before do
        @params = { email: user.email, password: 'bad_password' }
        post login_url, params: @params, as: :json
      end
      it 'should return unauthorized' do
        assert_response :unauthorized
      end
      it 'should return an error message' do
        expect(JSON(response.body)['message']).to eq('Incorrect password')
      end
    end
    context 'with nonexistant email' do
      before do
        @params = { email: 'bademail', password: 'bad_password' }
        post login_url, params: @params, as: :json
      end
      it 'should return unauthorized' do
        assert_response :unauthorized
      end
      it 'should return an error message' do
        expect(JSON(response.body)['message']).to eq("User doesn't exist")
      end
    end
    context 'with missing password' do
      before do
        @params = { email: user.email }
        post login_url, params: @params, as: :json
      end
      it 'should return an error' do
        assert_response :bad_request
      end
      it 'should return an error message' do
        expect(JSON(response.body)['message']).to eq('Please send both email and password')
        expect(JSON(response.body)['error']).to eq('param is missing or the value is empty: password')
      end
    end
    context 'with missing email' do
      before do
        @params = { password: user_password }
        post login_url, params: @params, as: :json
      end
      it 'should return an error' do
        assert_response :bad_request
      end
      it 'should return an error message' do
        expect(JSON(response.body)['message']).to eq('Please send both email and password')
        expect(JSON(response.body)['error']).to eq('param is missing or the value is empty: email')
      end
    end
  end
end
