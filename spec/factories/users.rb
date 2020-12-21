FactoryBot.define do
  factory :user do
    nickname { Faker::Name.initials(number: 2) }
    email { Faker::Internet.free_email }
    password { "abc123" }
    password_confirmation { password }
    grade_id { Faker::Number.between(from: 2, to: 10) }
  end
end
