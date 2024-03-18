# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rollout, type: :model do
  describe 'a valid Rollout' do
    let(:rollout) { create(:rollout, :with_user) }

    context 'that has working validations' do
      it 'is valid with valid attributes' do
        expect(rollout).to be_valid
      end
      it 'is not valid without a name' do
        rollout.name = nil
        expect(rollout).to_not be_valid
      end
      it 'is not valid without a percent_enabled' do
        rollout.percent_enabled = nil
        expect(rollout).to_not be_valid
      end
      it 'is not valid without an approved resource_type' do
        rollout.resource_type = nil
        expect(rollout).to_not be_valid

        rollout.resource_type = 'something'
        expect(rollout).to_not be_valid

        rollout.resource_type = 'instrument'
        expect(rollout).to be_valid
      end
    end
  end
end
