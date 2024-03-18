# frozen_string_literal: true

FactoryBot.define do
  factory :rollout do
    name { Faker::IndustrySegments.industry.parameterize.underscore }
    percent_enabled { 0 }
    offset { 0 }
    overrides { [] }
    resource_type { 'User' }
    trait :with_user_resource do
      resource_type { 'User' }
    end
    # trait :with_overrides do
    #   overrides { [association(:role, name: role)] }
    # end
  end
end
