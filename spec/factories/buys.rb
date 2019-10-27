FactoryBot.define do
  factory :buy do
    point { 100 }
    association :user
    association :item
  end
end
