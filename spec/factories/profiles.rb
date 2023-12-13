FactoryBot.define do
  factory :profile do
    user { association(:user) }
    instrument { association(:instrument) }
  end
end
