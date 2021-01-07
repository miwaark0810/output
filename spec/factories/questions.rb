FactoryBot.define do
  factory :question do
    subject { Faker::Lorem.word }
    title { Faker::Lorem.word }
    text { Faker::Lorem.sentence }
    association :user
  end
end
