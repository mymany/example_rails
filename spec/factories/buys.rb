FactoryBot.define do
  factory :buy do
    point { Faker::Number.within(range: 1..100) }
    association :user
    association :item
  end
end
