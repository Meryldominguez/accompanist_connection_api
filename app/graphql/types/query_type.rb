# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
      argument :id, ID, required: true, description: 'ID of the object.'
    end

    def node(id:)
      context.schema.object_from_id(id, context)
    end

    field :nodes, [Types::NodeType, { null: true }], null: true,
                                                     description: 'Fetches a list of objects given a list of IDs.' do
      argument :ids, [ID], required: true, description: 'IDs of the objects.'
    end

    def nodes(ids:)
      ids.map { |id| context.schema.object_from_id(id, context) }
    end

    # Add root-level fields here.
    # They will be entry points for queries on your schema.

    field :users, [Types::UserType], null: true do
      description 'find all Users'
    end

    field :user, [Types::UserType], null: true do
      description 'find User by id'
      argument :id, ID, required: true
    end

    def users
      User.all
    end

    def user(id:)
      User.find(id)
    end

    field :profiles, [Types::ProfileType], null: true do
      description 'find all Profiles'
    end

    field :profile, [Types::ProfileType], null: true do
      description 'find Profile by id'
      argument :id, ID, required: true
    end

    def profiles
      Profile.all
    end

    def profile(id:)
      Profile.find(id)
    end

    field :instruments, [Types::InstrumentType], null: true do
      description 'find all Instruments'
    end

    field :instrument, [Types::InstrumentType], null: true do
      description 'find Instrument by id'
      argument :id, ID, required: true
    end

    def instruments
      Instrument.all
    end

    def instrument(id:)
      Instrument.find(id)
    end
  end
end
