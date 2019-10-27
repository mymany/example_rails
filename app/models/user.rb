class User < ApplicationRecord
    has_secure_password
    has_many :items
    has_many :buys, through: :buys
    INITIAL_POINT = 10000
end
