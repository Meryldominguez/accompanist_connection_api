require 'rails_helper'

RSpec.describe Role, type: :model do
  describe "a valid Role" do
    fixtures :roles
    it "is valid with valid attributes" do
      subject = roles(:admin)
      expect(subject).to be_valid
    end
    it "is not valid without a name" do
      subject = roles(:admin)
      subject.name=nil
      expect(subject).to_not be_valid
    end
  end
end
