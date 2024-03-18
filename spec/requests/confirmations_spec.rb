# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Confirmations', type: :request do
  include ControllerHelper
  describe 'POST /resend' do
    context 'a normal User ' do
      context 'without confirmation' do
        let(:user) { create(:user, :unconfirmed) }
        it 'resends the email with a token' do
          expect(find_mail_to(user.email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(user),
                                         params: { confirmation: { email: user.email } }
          expect(response).to have_http_status(:ok)
          expect(JSON(response.body)['message']).to eq 'Email with confirmation has been resent'
          expect(find_mail_to(user.email)).to_not be nil
        end
      end
      context 'with a confirmation already' do
        let(:user) { create(:user) }
        it 'responds with an error' do
          expect(find_mail_to(user.email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(user),
                                         params: { confirmation: { email: user.email } }
          expect(response).to have_http_status(:bad_request)
          expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
          expect(find_mail_to(user.email)).to be nil
        end
      end
      context 'resending to another user' do
        let(:user) { create(:user) }
        let(:user_two) { create(:user) }
        it 'responds with an error' do
          expect(find_mail_to(user_two.email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(user),
                                         params: { confirmation: { email: user_two.email } }
          expect(response).to have_http_status(:unauthorized)
          expect(JSON(response.body)['message']).to eq 'You are not authorized to do this'
          expect(find_mail_to(user_two.email)).to be nil
        end
      end
    end
    context 'an admin user' do
      let(:admin_user) { create(:user, :admin_user) }
      context 'resending to an unconfirmed user' do
        let(:user) { create(:user, :unconfirmed) }

        it 'resends the email with a token' do
          expect(find_mail_to(user.email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(admin_user),
                                         params: { confirmation: { email: user.email } }
          expect(response).to have_http_status(:ok)
          expect(JSON(response.body)['message']).to eq 'Email with confirmation has been resent'
          expect(find_mail_to(user.email)).to_not be nil
        end
      end
      context 'resending to an already confirmed user' do
        let(:user) { create(:user) }
        it 'responds with an error' do
          expect(find_mail_to(user.email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(admin_user),
                                         params: { confirmation: { email: user.email } }
          expect(response).to have_http_status(:bad_request)
          expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
          expect(find_mail_to(user.email)).to be nil
        end
      end
      context 'resending to a nonexistant user' do
        it 'responds with an error' do
          email = Faker::Internet.email
          expect(find_mail_to(email)).to be nil
          post resend_confirmation_path, headers: create_auth_header(admin_user), params: { confirmation: { email: } }
          expect(response).to have_http_status(:bad_request)
          expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
          expect(find_mail_to(email)).to be nil
        end
      end
    end
  end
  describe 'POST /' do
    context 'a normal user' do
      context 'without confirmation' do
        context 'with correct token' do
          let(:user) { create(:user, :unconfirmed) }
          let(:token) { user.generate_confirmation_token }
          it 'confirms the user' do
            expect(user.confirmed_at).to be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: token } }
            expect(response).to have_http_status(:ok)
            expect(JSON(response.body)['message']).to eq 'Your account has been confirmed'
            expect(User.find(user.id).confirmed_at).to_not be nil
          end
        end
        context 'with other user token' do
          let(:user) { create(:user) }
          let(:user_two) { create(:user, :unconfirmed) }
          let(:token) { user_two.generate_confirmation_token }
          it 'confirms the user' do
            expect(user_two.confirmed_at).to be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: token } }
            expect(response).to have_http_status(:unauthorized)
            expect(JSON(response.body)['message']).to eq 'You are not authorized to do this'
            expect(User.find(user_two.id).confirmed_at).to be nil
          end
        end
        context 'with incorrect token' do
          let(:user) { create(:user, :unconfirmed) }
          it 'returns an error' do
            expect(user.confirmed_at).to be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: 'bad_token' } }
            expect(response).to have_http_status(:bad_request)
            expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
            expect(User.find(user.id).confirmed_at).to be nil
          end
        end
      end
      context 'with confirmation already' do
        context 'with correct token' do
          let(:user) { create(:user) }
          let(:token) { user.generate_confirmation_token }
          it 'throws an error' do
            expect(user.confirmed_at).to_not be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: token } }
            expect(response).to have_http_status(:bad_request)
            expect(User.find(user.id).confirmed_at).to eql user.confirmed_at
          end
        end
        context 'with other user token' do
          let(:user) { create(:user) }
          let(:user_two) { create(:user, :unconfirmed) }
          let(:token) { user_two.generate_confirmation_token }
          it 'throws an error' do
            expect(user_two.confirmed_at).to be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: token } }
            expect(response).to have_http_status(:unauthorized)
            expect(JSON(response.body)['message']).to eq 'You are not authorized to do this'
            expect(User.find(user_two.id).confirmed_at).to be nil
          end
        end
        context 'with incorrect token' do
          let(:user) { create(:user) }
          it 'throws an error' do
            expect(user.confirmed_at).to_not be nil
            post confirm_path, headers: create_auth_header(user),
                               params: { confirmation: { confirmation_token: 'bad_token' } }
            expect(response).to have_http_status(:bad_request)
            expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
            expect(User.find(user.id).confirmed_at).to_not be nil
          end
        end
      end
    end
    context 'an admin user' do
      context 'with correct token' do
        let(:admin) { create(:user, :admin_user) }
        let(:user) { create(:user, :unconfirmed) }
        let(:token) { user.generate_confirmation_token }
        it 'confirms the user' do
          expect(user.confirmed_at).to be nil
          post confirm_path, headers: create_auth_header(admin),
                             params: { confirmation: { confirmation_token: token } }
          expect(response).to have_http_status(:ok)
          expect(JSON(response.body)['message']).to eq 'Your account has been confirmed'
          expect(User.find(user.id).confirmed_at).to_not be nil
        end
      end
      context 'with invalid token' do
        let(:user) { create(:user, :admin_user) }
        it 'returns an error' do
          post confirm_path, headers: create_auth_header(user),
                             params: { confirmation: { confirmation_token: 'bad_token' } }
          expect(response).to have_http_status(:bad_request)
          expect(JSON(response.body)['message']).to eq 'We could not find a user with that email or that email has already been confirmed'
        end
      end
    end
  end
end
