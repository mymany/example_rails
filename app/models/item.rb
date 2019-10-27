class Item < ApplicationRecord
    belongs_to :user
    has_many :buys, through: :buys
end
