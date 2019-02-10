FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    name { Faker::Name.name }
    address { Faker::Address.full_address }
    department { Faker::Company.industry }

    trait :admin do
      admin { true }
    end
  end
end
