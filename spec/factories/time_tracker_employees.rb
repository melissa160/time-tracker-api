FactoryBot.define do
  factory :time_tracker_employee do
    user
    tag { Faker::HarryPotter.location }
  end
end
