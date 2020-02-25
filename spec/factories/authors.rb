FactoryBot.define do
  factory :author do
    first_name { Faker::Games::ElderScrolls.first_name }
    last_name { Faker::Games::ElderScrolls.last_name }
    bio { Faker::Lorem.paragraph }
  end
end
