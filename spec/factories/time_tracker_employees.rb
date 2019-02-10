FactoryBot.define do
  factory :time_tracker_employee do
    user_id { nil }
    tag { Faker::HarryPotter.location }
    trait :in do
      type_tracker { "in" }
    end
    trait :out do
      type_tracker { "out" }
    end
  end
end
