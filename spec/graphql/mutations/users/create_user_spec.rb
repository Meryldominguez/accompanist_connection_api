# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Users
    RSpec.describe CreateUser, type: :graphql do
      let(:mutation) do
        <<~GQL
          mutation($input: CreateUserInput!){
            createUser(input: $input) {
              id,name,email,createdAt
            }
          }
        GQL
      end

      describe '.resolve' do
        it 'creates a User' do
          user = build(:user)
          input = { firstName: user.first_name, lastName: user.last_name, email: user.email, password: user.password }

          expect(User.count).to be 0
          expect do
            execute_graphql(mutation, variables: { input: })
          end.to change { User.count }.by(1)
        end

        it 'returns a User' do
          user = build(:user)
          input = { firstName: user.first_name, lastName: user.last_name, email: user.email, password: user.password }
          response = execute_graphql(mutation, variables: { input: })

          data = response['data']['createUser']

          expect(data).to include(
            'id' => be_present,
            'name' => user.full_name,
            'email' => user.email,
            'createdAt' => be_present
          )
        end
      end
    end
  end
end
