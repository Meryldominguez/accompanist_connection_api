# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Rollout, type: :model do
  describe 'a valid Rollout' do
    context 'that has working validations' do
      let(:rollout) { create(:rollout, :with_user_resource) }

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
    context 'can calculate enablement' do
      let(:rollout) { create(:rollout, :with_user_resource) }
      context 'with #id_enabled?' do
        it 'with 0 percent enabled' do
          expect(rollout.percent_enabled).to(be { 0 })
          results = []
          (1..1000).each do |num|
            result = rollout.id_enabled?(num)
            results.append(result)
          end

          expect(results.tally[true]).to be_nil
        end

        context 'with 25 percent enabled' do
          before do
            rollout.percent_enabled = 25
            expect(rollout.percent_enabled).to(be { 25 })
          end

          it 'and a large data set' do
            results = []
            (1..1000).each do |num|
              result = rollout.id_enabled?(num)
              results.append(result)
            end

            expect(results.tally[true].to_f / 1000).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end

          it 'and a small data set' do
            sample_size = 50
            results = []
            (1..sample_size).each do |num|
              result = rollout.id_enabled?(num, total: sample_size)
              results.append(result)
            end
            expect(results.tally[true].to_f / sample_size).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end
        end
        context 'with 50 percent enabled' do
          before do
            rollout.percent_enabled = 50
            expect(rollout.percent_enabled).to(be { 50 })
          end

          it 'and a large data set' do
            results = []
            (1..1000).each do |num|
              result = rollout.id_enabled?(num)
              results.append(result)
            end

            expect(results.tally[true].to_f / 1000).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end

          it 'and a small data set' do
            sample_size = 50
            results = []
            (1..sample_size).each do |num|
              result = rollout.id_enabled?(num, total: sample_size)
              results.append(result)
            end
            expect(results.tally[true].to_f / sample_size).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end
        end
        context 'with 75 percent enabled' do
          before do
            rollout.percent_enabled = 75
            expect(rollout.percent_enabled).to(be { 75 })
          end

          it 'and a large data set' do
            results = []
            (1..1000).each do |num|
              result = rollout.id_enabled?(num)
              results.append(result)
            end

            expect(results.tally[true].to_f / 1000).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end

          it 'and a small data set' do
            sample_size = 50
            results = []
            (1..sample_size).each do |num|
              result = rollout.id_enabled?(num, total: sample_size)
              results.append(result)
            end

            expect(results.tally[true].to_f / sample_size).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end
        end
        context 'with 100 percent enabled' do
          before do
            rollout.percent_enabled = 100
            expect(rollout.percent_enabled).to(be { 100 })
          end

          it 'and a large data set' do
            results = []
            (1..1000).each do |num|
              result = rollout.id_enabled?(num)
              results.append(result)
            end

            expect(results.tally[true].to_f / 1000).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end

          it 'and a small data set' do
            sample_size = 50
            results = []
            (1..sample_size).each do |num|
              result = rollout.id_enabled?(num, total: sample_size)
              results.append(result)
            end
            expect(results.tally[true].to_f / sample_size).to be_within(0.05).of(rollout.percent_enabled / 100.to_f)
          end
        end
      end
    end

    context 'with overrides' do
      let(:user) { create(:user) }
      let(:user2) { create(:user) }
      let(:user3) { create(:user) }
      let(:rollout) { create(:rollout, :with_user_resource) }
      let!(:rollout_override_allow) { create(:rollout_override, resource: user2, rollout:, allow: true) }
      let!(:rollout_override_deny) { create(:rollout_override, resource: user3, rollout:, allow: false) }

      it 'can add an override' do
        rollout.add_override(user, true)
        expect(RolloutOverride.count).to(be { 3 })
      end
      it 'can remove an override' do
        rollout.remove_override(user2)
        expect(RolloutOverride.count).to(be { 1 })
      end

      it 'enablement matches override' do
        expect(rollout.percent_enabled).to(be { 0 })
        expect(rollout.resource_enabled?(user)).to be false
        expect(rollout.resource_enabled?(user2)).to be true
        expect(rollout.resource_enabled?(user3)).to be false

        rollout.percent_enabled = 100

        expect(rollout.percent_enabled).to(be { 100 })
        expect(rollout.resource_enabled?(user)).to be true
        expect(rollout.resource_enabled?(user2)).to be true
        expect(rollout.resource_enabled?(user3)).to be false
      end
    end
  end
end
