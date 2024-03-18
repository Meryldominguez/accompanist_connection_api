# frozen_string_literal: true

require 'rails_helper'

RSpec.describe RolloutOverride, type: :model do
  describe 'RolloutOverride' do
    let(:rollout) { create(:rollout, :with_user_resource) }
    let(:user) { create(:user) }
    let(:rollout_override) { create(:rollout_override) }
    let(:instrument) { create(:instrument) }

    context 'that has working validations' do
      it 'is valid with valid attributes' do
        expect(rollout_override).to be_valid
      end
      it 'is not valid without an allow' do
        rollout_override.allow = nil
        expect(rollout_override).to_not be_valid
      end
      it 'is not valid without a resource' do
        rollout_override.resource = nil
        expect(rollout_override).to_not be_valid
      end
      it 'is not valid without a rollout' do
        rollout_override.rollout = nil
        expect(rollout_override).to_not be_valid
      end
      it 'is not valid if the resource class doesnt match the resource_type of the rollout' do
        expect(rollout_override).to be_valid
        rollout_override.resource = instrument
        expect(rollout_override).to_not be_valid
      end
    end

    it 'Cannot be created with the same resource and rollout' do
      RolloutOverride.create!(rollout_id: rollout.id, resource: user, allow: true)
      expect { RolloutOverride.create!(rollout_id: rollout.id, resource: user, allow: true) }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end
