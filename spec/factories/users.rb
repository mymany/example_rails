FactoryBot.define do
        factory :user do
            email { "dummy@example.com" }
            password { "password" }
            point { 10000 }
        end
end