class Episode < ApplicationRecord
  belongs_to :season
  has_many :viewings, dependent: :destroy
end
