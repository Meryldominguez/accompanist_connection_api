require 'rails_helper'

RSpec.describe User, type: :model do
  describe "a valid User" do
    fixtures :users

    it "is valid with valid attributes" do
      subject = users(:one)
      expect(subject).to be_valid
    end
    it "is not valid without a first_name" do
      subject = users(:one)
      subject.first_name=nil
      expect(subject).to_not be_valid
    end
    it "is not valid without a last_name" do
      subject = users(:one)
      subject.last_name=nil
      expect(subject).to_not be_valid
    end
    it "is not valid without an email" do
      subject = users(:one)
      subject.email=nil
      expect(subject).to_not be_valid
    end
    it "is not valid with a bad email" do
      subject = users(:one)
      subject.email='bademail'
      expect(subject).to_not be_valid
    end
    it "is not valid with a duplicate email" do
      subject = users(:one)
      subject_two = users(:two)
      subject.email=subject_two.email
      expect(subject).to_not be_valid
    end

  end
end
