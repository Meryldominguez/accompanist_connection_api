# frozen_string_literal: true

module Types
  module Inputs
    class FindUserInputType < Types::BaseInputObject
      one_of
      argument :email, String, 'Find user by email', required: false
      argument :id, ID, 'Find user by Id', required: false
    end
  end
end
