class Serie < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons
  has_many :likes, dependent: :destroy
  has_many :viewings, as: :viewable, dependent: :destroy
  has_one_attached :photo
  GENRELIST = ["Animation","Action & Adventure", "Comedy", "Crime", "Drama", "Mystery", "Sci-Fi & Fantasy", "War & Politics"]
  PLATFORMLIST = ["Amazon Prime", "BBC One", "Disney+", "HBO", "Netflix"]

  def episode_count
    counter = 0
    seasons.each do |season|
      counter += season.episodes.count
    end
    counter
  end

  def viewed?(user)
    Viewing.find_by(viewable: self, user: user)
  end
end
