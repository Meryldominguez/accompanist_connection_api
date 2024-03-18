# frozen_string_literal: true

require 'rails_helper'

module Mutations
  module Instruments
    RSpec.describe CreateInstrument, type: :graphql do
      let(:mutation) do
        <<~GQL
          mutation($input: CreateInstrumentInput!){
            createInstrument(input: $input) {
              id,name,createdAt
            }
          }
        GQL
      end

      describe '.resolve' do
        it 'creates a Instrument' do
          instrument = build(:instrument)
          input = { name: instrument.name }

          expect(Instrument.count).to be 0
          expect do
            execute_graphql(mutation, variables: { input: })
          end.to change { Instrument.count }.by(1)
        end

        it 'returns an Instrument' do
          instrument = build(:instrument)
          input = { name: instrument.name }
          response = execute_graphql(mutation, variables: { input: })

          data = response['data']['createInstrument']

          expect(data).to include(
            'id' => be_present,
            'name' => instrument.name,
            'createdAt' => be_present
          )
        end
      end
    end
  end
end
