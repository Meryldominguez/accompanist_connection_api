# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'a valid User' do
    let(:user) { create(:user) }
    it 'is valid with valid attributes' do
      expect(user).to be_valid
    end
    it 'is not valid without a first_name' do
      user.first_name = nil
      expect(user).to_not be_valid
    end
    it 'is not valid without a last_name' do
      user.last_name = nil
      expect(user).to_not be_valid
    end
    it 'is not valid without an email' do
      user.email = nil
      expect(user).to_not be_valid
    end
    it 'is not valid without a password' do
      user.password_digest = nil
      expect(user).to_not be_valid
    end
    it 'is not valid with a bad email' do
      user.email = 'bademail'
      expect(user).to_not be_valid
    end
    it 'is not valid with a duplicate email' do
      user_two = create(:user)
      user.email = user_two.email
      expect(user).to_not be_valid
    end
    it 'it downcases email' do
      bad_format_email = 'UPPERCASE@email.com'
      user.email = bad_format_email
      user.save
      expect(user.email).to eq bad_format_email.downcase
    end
  end
  describe 'The #admin? function' do
    context 'with a user with an admin role' do
      let(:admin_user) { build(:user, :admin_user) }
      it 'returns true' do
        expect(admin_user.role?(:admin)).to be true
      end
    end
  end
  describe 'The #admin? function' do
    context 'with a user with an admin role' do
      let(:admin_user) { build(:user, :admin_user) }
      it 'returns true' do
        expect(admin_user.admin?).to be true
      end
    end
    context 'with a user with another role' do
      let(:user) { build(:user, :with_role, role: 'moderator') }
      it 'returns false' do
        expect(user.admin?).to be false
      end
    end
    context 'with a user with no role' do
      let(:user) { build(:user) }
      it 'returns false' do
        expect(user.admin?).to be false
      end
    end
  end
  describe 'The #role? function' do
    context 'with a user with a role' do
      let(:user) { build(:user, :with_role, role: 'moderator') }
      it 'returns true when the role matches the parameter' do
        expect(user.role?(:moderator)).to be true
      end
      it 'returns false when the role does not match the parameter' do
        expect(user.role?(:admin)).to be false
      end
    end
    context 'with a user with no role' do
      let(:user) { build(:user) }
      it 'returns false' do
        expect(user.role?(:moderator)).to be false
      end
    end
  end

  describe 'The #add_admin function' do
    context 'with a normal user' do
      let(:user) { create(:user) }
      let!(:role) { create(:admin_role) }

      it 'adds the admin role' do
        expect(user.roles.map(&:name)).not_to include 'admin'
        user.make_admin
        expect(user.roles.map(&:name)).to include 'admin'
      end
    end
    context 'with a user that already has the admin role' do
      let(:user) { create(:user, :admin_user) }
      it 'throws an error' do
        expect(user.roles.map(&:name)).to include 'admin'
        expect { user.make_admin }.to raise_error(ActiveRecord::RecordNotUnique)
      end
    end
  end
  describe 'The #remove_role function' do
    let!(:role) { create(:role, name: 'moderator') }

    context 'with a user with a role' do
      let(:user) { create(:user) }

      it 'removes the role from the user' do
        user.roles << role

        expect(user.role?(:moderator)).to be true
        user.remove_role(:moderator)
        expect(user.role?(:moderator)).to be false
      end
    end
    context 'with a user with no role' do
      let!(:user) { create(:user) }
      it 'returns an error' do
        expect do
          user.remove_role(:moderator)
        end.to raise_error(Exceptions::ResourceNotConnectedError)
      end
    end
  end
end
