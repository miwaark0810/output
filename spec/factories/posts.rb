FactoryBot.define do
  factory :post do
    subject { Faker::Lorem.word }
    title { Faker::Lorem.word }
    text { Faker::Lorem.sentence }
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
