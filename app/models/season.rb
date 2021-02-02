class Season < ApplicationRecord
  belongs_to :serie
  has_many :episodes, dependent: :destroy
  has_one_attached :photo
end
