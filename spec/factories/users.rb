FactoryBot.define do
  factory :user do
    first_name { 'Josh' }
    last_name  { 'Blue' }
    email { Faker::Internet.email }

    trait :with_role do
      transient do
        role { nil }
      end 
      roles { [association(:role, name:role)] }
    end
    
    factory :admin_user, class: User do
      roles { [association(:admin_role)] }
    end
  end
end
