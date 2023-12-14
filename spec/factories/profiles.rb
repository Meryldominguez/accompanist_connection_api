# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    user { association(:user) }
    instrument { association(:instrument) }
  end
end
