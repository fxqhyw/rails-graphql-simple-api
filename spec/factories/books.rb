FactoryBot.define do
  factory :book do
    title { Faker::Book.title }
    description { Faker::Lorem.paragraph }
    publication_year { rand(1800..2020) }
    author
  end
end
