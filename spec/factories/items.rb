FactoryBot.define do
  factory :item do
    name { Faker::Name.initials }
    point { 100 }
    association :user
  end
end