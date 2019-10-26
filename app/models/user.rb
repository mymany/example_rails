class User < ApplicationRecord
    has_secure_password
    has_many :items
    INITIAL_POINT = 10000
end
