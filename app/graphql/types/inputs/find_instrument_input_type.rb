# frozen_string_literal: true

module Types
  module Inputs
    class FindInstrumentInputType < Types::BaseInputObject
      one_of
      argument :name, String, 'Find instrument by name', required: false
      argument :id, ID, 'Find instrument by Id', required: false
    end
  end
end
