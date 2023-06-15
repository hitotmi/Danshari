FactoryBot.define do
  factory :post_comment do
    comment { Faker::Lorem.characters(number:10) }
    user
    counseling_post
  end
end