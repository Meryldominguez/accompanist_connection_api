# frozen_string_literal: true

class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :first_name, :last_name, :email, :full_name
  # has_many :profiles, :roles
end
