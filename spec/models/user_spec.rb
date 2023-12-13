require 'rails_helper'

RSpec.describe User, type: :model do
  describe "a valid User" do
    let(:user) { build(:user) }
    it "is valid with valid attributes" do
      expect(user).to be_valid
    end
    it "is not valid without a first_name" do
      user.first_name=nil
      expect(user).to_not be_valid
    end
    it "is not valid without a last_name" do
      user.last_name=nil
      expect(user).to_not be_valid
    end
    it "is not valid without an email" do
      user.email=nil
      expect(user).to_not be_valid
    end
    it "is not valid with a bad email" do
      user.email='bademail'
      expect(user).to_not be_valid
    end
    it "is not valid with a duplicate email" do
      user_two = create(:user)
      user.email=user_two.email
      expect(user).to_not be_valid
    end
  end
  describe "The #admin? function" do
    context "with a user with an admin role" do
      let(:admin_user) { build(:admin_user) }
      it "returns true" do
        expect(admin_user.role?(:admin)).to be true
      end
    end
  end
  describe "The #admin? function" do
    context "with a user with an admin role" do
      let(:admin_user) { build(:admin_user) }
      it "returns true" do
        expect(admin_user.admin?).to be true
      end
    end
    context "with a user with another role" do
      let(:user) { build(:user, :with_role, role: "moderator") }
      it "returns false" do
        expect(user.admin?).to be false
      end
    end
    context "with a user with no role" do
      let(:user) { build(:user) }
      it "returns false" do
        expect(user.admin?).to be false
      end
    end
  end
  describe "The #role? function" do
    context "with a user with a role" do
      let(:user) { build(:user, :with_role, role: "moderator") }
      it "returns true when the role matches the parameter" do
        expect(user.role?(:moderator)).to be true
      end
      it "returns false when the role does not match the parameter" do
        expect(user.role?(:admin)).to be false
      end
    end
    context "with a user with no role" do
      let(:user) { build(:user) }
      it "returns false" do
        expect(user.role?(:moderator)).to be false
      end
    end
  end
  
  
  
end
