# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_user, mutation: Mutations::CreateUser
    field :create_profile, mutation: Mutations::CreateProfile
    field :create_instrument, mutation: Mutations::CreateInstrument
  end
end
