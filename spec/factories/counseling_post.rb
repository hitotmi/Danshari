FactoryBot.define do
  factory :counseling_post do
    user
    title { Faker::Lorem.characters(number:10) }
    content { Faker::Lorem.characters(number:30) }
    status { :answer_reception }
    usage_frequency { :everyday }
    star { 0 }

    after(:create) do |counseling_post|
      counseling_post.tags = Tag.limit(3)
    end
  end
end
