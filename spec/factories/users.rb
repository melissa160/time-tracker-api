FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password {"ouuhonuhn123eu"}

    trait :admin do
      admin { true }
    end
  end
end
