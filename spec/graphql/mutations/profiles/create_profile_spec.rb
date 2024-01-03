# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Profiles
    RSpec.describe CreateProfile, type: :graphql do
      let(:mutation) do
        <<~GQL
          mutation($input: CreateProfileInput!){
            createProfile(input: $input) {
              id,userId,instrumentId,createdAt
            }
          }
        GQL
      end

      describe '.resolve' do
        context do
          let!(:user) { create(:user) }
          let!(:instrument) { create(:instrument) }
          context 'with user email' do
            let(:input) { { user: { email: user.email } } }
            context 'and existing instrument name' do
              it 'creates a profile' do
                input[:instrument] = { name: instrument.name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'returns a Profile' do
                input = { user: { id: user.id }, instrument: { id: instrument.id } }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => instrument.id,
                  'createdAt' => be_present
                )
              end
            end
            context 'and existing instrument id' do
              it 'creates a profile' do
                input[:instrument] = { id: instrument.id }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'returns a Profile' do
                input = { user: { id: user.id }, instrument: { id: instrument.id } }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => instrument.id,
                  'createdAt' => be_present
                )
              end
            end
            context 'and nonexistant instrument name' do
              it 'creates a profile' do
                input[:instrument] = { name: build(:instrument).name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'creates an instrument' do
                input[:instrument] = { name: build(:instrument).name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Instrument.count }.by(1)
              end
              it 'returns a Profile' do
                input = { user: { id: user.id }, instrument: { id: instrument.id } }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => instrument.id,
                  'createdAt' => be_present
                )
              end
            end
          end
          context 'with user id' do
            let(:input) { { user: { id: user.id } } }
            context 'and existing instrument name' do
              it 'creates a profile' do
                input[:instrument] = { name: instrument.name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'returns a Profile' do
                input[:instrument] = { name: instrument.name }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => instrument.id,
                  'createdAt' => be_present
                )
              end
            end
            context 'and existing instrument id' do
              it 'creates a profile' do
                input[:instrument] = { id: instrument.id }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'returns a Profile' do
                input[:instrument] = { id: instrument.id }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => instrument.id,
                  'createdAt' => be_present
                )
              end
            end
            context 'and nonexistant instrument name' do
              it 'creates a profile' do
                input[:instrument] = { name: build(:instrument).name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Profile.count }.by(1)
              end
              it 'creates an instrument' do
                input[:instrument] = { name: build(:instrument).name }
                expect do
                  execute_graphql(mutation, variables: { input: })
                end.to change { Instrument.count }.by(1)
              end
              it 'returns a Profile' do
                input[:instrument] = { name: build(:instrument).name }
                response = execute_graphql(mutation, variables: { input: })

                data = response['data']['createProfile']

                expect(data).to include(
                  'id' => be_present,
                  'userId' => user.id,
                  'instrumentId' => be_present,
                  'createdAt' => be_present
                )
              end
            end
          end
        end
      end
    end
  end
end
