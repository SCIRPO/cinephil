class Serie < ApplicationRecord
    has_many :seasons, dependent: :destroy
    has_many :episodes, through: :seasons
end
