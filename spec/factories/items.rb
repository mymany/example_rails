FactoryBot.define do
  factory :item do
    name { "dummy item" }
    point { 100 }
    association :user
  end
end