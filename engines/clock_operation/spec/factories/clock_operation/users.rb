FactoryBot.define do
  factory :user, class: ClockOperation::User do
    name { Faker::Name.name }
    email { "teacher@iwa.com" }
  end
end
