class Episode < ApplicationRecord
  belongs_to :season
  has_many :viewings, dependent: :destroy
  has_one_attached :photo
end
