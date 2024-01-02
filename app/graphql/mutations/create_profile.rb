# frozen_string_literal: true

module Mutations
  class CreateProfile < BaseMutation
    # arguments passed to the `resolve` method
    argument :user, Types::Inputs::FindUserInputType, required: true
    argument :instrument, Types::Inputs::FindInstrumentInputType, required: true

    # return type from the mutation
    type Types::ProfileType

    def resolve(user: nil, instrument: nil)
      @user = if user.id
                User.find(user.id)
              elsif user.email
                User.find_by(email: user.email)
              end
      @instrument = if instrument.id
                      Instrument.find(instrument.id)
                    elsif instrument.name
                      Instrument.find_by(name: instrument.name)
                    end

      # @instrument = Instrument.create!(name: instrument.name) unless instrument.name && @instrument

      Profile.create!(
        instrument: @instrument,
        user: @user
      )
    end
  end
end
