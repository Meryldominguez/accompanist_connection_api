# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rollout, type: :model do
  describe 'a valid Rollout' do
    let(:rollout) { create(:rollout, :with_user) }

    context 'that has working validations' do

      it 'is valid with valid attributes' do
        print(rollout)

    #     expect(rollout).to be_valid
      end
    #   it 'is not valid without a name' do
    #     rollout.name = nil
    #     expect(rollout).to_not be_valid
    #   end
    #   # it 'is not valid without a percent_enabled' do
    #   #   rollout.percent_enabled = nil
    #   #   expect(rollout).to_not be_valid
    #   # end
    #   it 'is not valid without an approved resource_type' do
    #     rollout.resource_type = nil
    #     expect(rollout).to_not be_valid

    #     rollout.resource_type = 'something'
    #     expect(rollout).to_not be_valid

    #     rollout.resource_type = 'instrument'
    #     expect(rollout).to be_valid
    #   end
    end
    # # context 'update_red_or_green_list' do
    # #   let(:user1) { create(:user) }
    # #   let(:user2) { create(:user) }
    # #   let(:user3) { create(:user) }
    # #   let(:instrument) { create(:instrument) }

    # #   # it 'can add a valid resource to the list' do
    # #   #   rollout.add_green_list_resource(user1)
    # #   #   expect(rollout.green_list).to include user1.id
    # #   #   rollout.add_red_list_resource(user2)
    # #   #   expect(rollout.red_list).to include user2.id
    # #   # end
    # #   # it 'returns false for invalid resources to the list' do
    # #   #   result = rollout.add_green_list_resource(instrument)
    # #   #   expect(result).to be false
    # #   #   result = rollout.add_red_list_resource(instrument)
    # #   #   expect(result).to be false
    # #   # end
    # # end
  end
end
