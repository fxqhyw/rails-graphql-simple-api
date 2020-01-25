FactoryBot.define do
  factory :book do
    title { "MyString" }
    description { "MyText" }
    publication_year { 1 }
    author { nil }
  end
end
