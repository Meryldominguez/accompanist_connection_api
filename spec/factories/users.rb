# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email { Faker::Internet.email }
    roles { [] }
    password_digest { Faker::Internet.password }

    trait :with_role do
      transient do
        role { nil }
      end
      roles { [association(:role, name: role)] }
    end

    trait :admin_user do
      roles { [association(:admin_role)] }
    end
  end
end
