# frozen_string_literal: true

module Mutations
  class CreateProfile < BaseMutation
    # arguments passed to the `resolve` method
    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :email, String, required: true
    argument :password, String, required: true

    # return type from the mutation
    type Types::UserType

    def resolve(first_name: nil, last_name: nil, email: nil, password: nil)
      User.create!(
        first_name:,
        last_name:,
        email:,
        password:
      )
    end
  end
end
