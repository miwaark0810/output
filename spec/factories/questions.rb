FactoryBot.define do
  factory :question do
    subject { Faker::Lorem.word }
    title { Faker::Lorem.characters(number: 7) }
    text { Faker::Lorem.sentence }
    association :user
  end
end
