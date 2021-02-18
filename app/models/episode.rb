class Episode < ApplicationRecord
  belongs_to :season
  has_many :viewings, as: :viewable, dependent: :destroy
  has_one_attached :photo
  delegate :serie, to: :season

  def viewed?(user)
    Viewing.find_by(viewable: self, user: user)
  end
end
