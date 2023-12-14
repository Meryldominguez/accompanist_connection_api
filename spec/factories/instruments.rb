# frozen_string_literal: true

FactoryBot.define do
  factory :instrument do
    name { Faker::Music.instrument }
  end
end
