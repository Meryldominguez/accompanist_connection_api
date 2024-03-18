# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :first_name, String
    field :last_name, String
    field :latitude, Float
    field :longitude, Float
    field :email, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :confirmed_at, GraphQL::Types::ISO8601DateTime
    field :admin, Boolean
    field :profiles, [Types::ProfileType], null: true

    def name
      object.full_name
    end

    def admin
      object.admin?
    end
  end
end
