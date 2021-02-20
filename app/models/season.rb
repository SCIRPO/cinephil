class Season < ApplicationRecord
  belongs_to :serie
  has_many :episodes, dependent: :destroy
  has_many :viewings, as: :viewable, dependent: :destroy
  has_one_attached :photo

  def viewed?(user)
    Viewing.find_by(viewable: self, user: user)
  end
end
