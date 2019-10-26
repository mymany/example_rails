class User < ApplicationRecord
    has_secure_password
    INITIAL_POINT = 10000
end
