require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "a valid Role" do
    let(:role) { build(:role) }
    it "is valid with valid attributes" do
      expect(role).to be_valid
    end
    it "is not valid without a name" do
      role.name=nil
      expect(role).to_not be_valid
    end
  end
end
