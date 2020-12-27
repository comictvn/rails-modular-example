FactoryBot.define do
  factory :user, class: Identity::User do
    name { Faker::Name.name }
    email { "teacher@iwa.com" }
    password { "password" }
  end
end
