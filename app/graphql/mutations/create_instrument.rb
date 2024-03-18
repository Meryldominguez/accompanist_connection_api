# frozen_string_literal: true

module Mutations
  class CreateInstrument < BaseMutation
    # arguments passed to the `resolve` method
    argument :name, String, required: true

    # return type from the mutation
    type Types::InstrumentType

    def resolve(name: nil)
      Instrument.create!(
        name:
      )
    end
  end
end
