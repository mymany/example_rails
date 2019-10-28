class Item < ApplicationRecord
    belongs_to :user
    has_many :buys, through: :buys
    validates :name, presence: true
    validates :point, presence: true, numericality: { only_integer: true }
end
