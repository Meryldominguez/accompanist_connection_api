# frozen_string_literal: true

FactoryBot.define do
  factory :role do
    name { Faker::Job }
  end

  factory :admin_role, class: Role do
    name { 'admin' }
  end
end
