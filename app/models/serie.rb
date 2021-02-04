class Serie < ApplicationRecord
    has_many :seasons, dependent: :destroy
    has_many :episodes, through: :seasons
    has_many :likes, dependent: :destroy
    has_one_attached :photo
end
