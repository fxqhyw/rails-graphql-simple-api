FactoryBot.define do
  factory :user do
    nickname { Faker::FunnyName.unique.name }
    email { Faker::Internet.unique.email }
    password { 'Password1' }
  end
end
