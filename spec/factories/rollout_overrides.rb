# frozen_string_literal: true

FactoryBot.define do
  factory :rollout_override do
    rollout { association(:rollout) }
    resource { association(:user) }
    allow { true }
  end
end
