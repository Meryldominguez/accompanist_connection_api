# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'Josh' }
    last_name  { 'Blue' }
    email { Faker::Internet.email }
    roles { [] }
    password_digest {Faker::Internet.password}
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
