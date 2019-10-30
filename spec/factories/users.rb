FactoryBot.define do
        factory :user do
            email { Faker::Internet.email }
            password { Faker::Alphanumeric.alphanumeric(number: 10) }
            point { 10000 }
        end
end