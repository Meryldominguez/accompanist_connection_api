# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  include ControllerHelper

  describe 'GET #index' do
    context 'with authenticated user' do
      let!(:user) { create(:user) }
      let!(:second_user) { create(:user) }
      before do
        get users_path, headers: create_auth_header(user)
      end
      it 'should return a 200 status' do
        expect(response).to have_http_status(:ok)
      end
      it 'should return all users' do
        expect(JSON(response.body)['data'].count).to be 2
        expect(JSON(response.body)['data'][0]['attributes']['id']).to equal user.id
      end
    end
    context 'with unauthenticated user' do
      let!(:user) { create(:user) }
      before do
        get users_path
      end
      it 'should return a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  describe 'GET #show' do
    context 'with authenticated user' do
      let!(:user) { create(:user) }
      let!(:second_user) { create(:user) }
      before do
        get user_path(user.id), headers: create_auth_header(user)
      end
      it 'should return a 200 status' do
        expect(response).to have_http_status(:ok)
      end
      it 'should return one user' do
        expect(JSON(response.body)['data']['attributes']['id']).to equal user.id
      end
      it 'should not allow user to view profile that isnt theirs' do
        pending 'Should this be allowed'
        raise
      end
    end
    context 'with unauthenticated user' do
      let!(:user) { create(:user) }
      before do
        get user_path(user.id)
      end
      it 'should return a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  describe 'POST #create' do
    let!(:user) { build(:user) }
    before do
      @user_count = User.count
      post users_path,
           params: { first_name: 'new', last_name: 'new', email: 'new@email.com',
                     password: 'password' }
    end
    it 'should return a 201 status' do
      expect(response).to have_http_status(:created)
    end
    it 'should create a new user' do
      expect(User.count).to equal @user_count + 1
    end
  end
  describe 'PATCH/PUT #update' do
    context 'with an authenticated user' do
      context 'who is an admin' do
        let!(:user) { create(:user) }
        let!(:admin_user) { create(:user, :admin_user) }
        context 'updating an account' do
          before do
            @new_email = 'new@email.com'
            patch user_path(user.id),
                  params: { email: @new_email },
                  headers: create_auth_header(admin_user)
          end
          it 'should return a 200 status' do
            expect(response).to have_http_status(:ok)
          end
          it 'should have the updated user in the body' do
            expect(JSON(response.body)['data']['attributes']['email']).to eq @new_email
          end
          it 'should update a user' do
            expect(User.find(user.id).email).to eq @new_email
          end
        end
      end
      context 'who is not an admin' do
        let!(:user) { create(:user) }
        context 'editing their own account' do
          before do
            @new_email = 'new@email.com'
            patch user_path(user.id),
                  params: { email: 'new@email.com' },
                  headers: create_auth_header(user)
          end
          it 'should return a 200 status' do
            expect(response).to have_http_status(:ok)
          end
          it 'should have the updated user in the body' do
            expect(JSON(response.body)['data']['attributes']['email']).to eq @new_email
          end
          it 'should update a user' do
            expect(User.find(user.id).email).to eq @new_email
          end
        end
        context "updating someone else's account" do
          let!(:user_two) { create(:user) }
          before do
            @new_email = 'new@email.com'
            patch user_path(user_two.id),
                  params: { email: 'new@email.com' },
                  headers: create_auth_header(user)
          end
          it 'should return a 401 status' do
            expect(response).to have_http_status(:unauthorized)
          end
          it 'should have an empty body' do
            expect(response.body).to eq ''
          end
          it 'should not edit a user' do
            expect(User.find(user_two.id).email).to_not eq @new_email
          end
        end
      end
    end
    context 'with unauthenticated user' do
      let(:user) { create(:user) }
      before do
        delete user_path(user.id)
      end
      it 'should return a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
  describe 'DELETE #destroy' do
    context 'with an authenticated user' do
      context 'who is an admin' do
        let!(:user) { create(:user) }
        let!(:admin_user) { create(:user, :admin_user) }
        context 'deleting an account' do
          before do
            @user_count = User.count
            delete user_path(user.id), headers: create_auth_header(admin_user)
          end
          it 'should return a 204 status' do
            expect(response).to have_http_status(:no_content)
          end
          it 'should have an empty body' do
            expect(response.body).to eq ''
          end
          it 'should delete a user' do
            expect(User.count).to equal @user_count - 1
            expect(User.all).to include admin_user
          end
        end
      end
      context 'who is not an admin' do
        let!(:user) { create(:user) }
        context 'deleting their own account' do
          before do
            @user_count = User.count
            delete user_path(user.id), headers: create_auth_header(user)
          end
          it 'should return a 204 status' do
            expect(response).to have_http_status(:no_content)
          end
          it 'should have an empty body' do
            expect(response.body).to eq ''
          end
          it 'should delete a user' do
            expect(User.count).to equal @user_count - 1
            expect(User.all).to_not include user
          end
        end
        context "deleting someone else's account" do
          let!(:user_two) { create(:user) }

          before do
            @user_count = User.count
            delete user_path(user_two.id), headers: create_auth_header(user)
          end
          it 'should return a 401 status' do
            expect(response).to have_http_status(:unauthorized)
          end
          it 'should have an empty body' do
            expect(response.body).to eq ''
          end
          it 'should not delete a user' do
            expect(User.count).to equal @user_count
            expect(User.all).to include user
          end
        end
      end
    end
    context 'with unauthenticated user' do
      let(:user) { create(:user) }
      before do
        delete user_path(user.id)
      end
      it 'should return a 401 status' do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
