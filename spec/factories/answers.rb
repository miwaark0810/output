FactoryBot.define do
  factory :answer do
    text { Faker::Lorem.sentence }
    association :user
    association :question
  end
end