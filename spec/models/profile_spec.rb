# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'a valid Profile' do
    let(:profile) { build(:profile) }
    it 'is valid with valid attributes' do
      expect(profile).to be_valid
    end
    it 'is not valid without a user' do
      profile.user = nil
      expect(profile).to_not be_valid
    end
    it 'is not valid without an instrument' do
      profile.instrument = nil
      expect(profile).to_not be_valid
    end
  end
end
