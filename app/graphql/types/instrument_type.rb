# frozen_string_literal: true

module Types
  class InstrumentType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :profiles, [Types::ProfileType], null: true
    field :profile_count, Integer, null: true

    def profile_count
      object.profiles.count
    end
  end
end
