# frozen_string_literal: true

FactoryBot.define do
  factory :rollout do
    name { Faker::IndustrySegments.industry.parameterize.underscore }
    # percent_enabled { 0 }
    offset { 0 }
    green_list { [] }
    red_list { [] }
    resource_type { 'User' }
    trait :with_user do
      resource_type { 'User' }
    end
  end
end
