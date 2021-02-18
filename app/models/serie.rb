class Serie < ApplicationRecord
  has_many :seasons, dependent: :destroy
  has_many :episodes, through: :seasons
  has_many :likes, dependent: :destroy
  has_many :viewings, as: :viewable, dependent: :destroy
  has_one_attached :photo
  GENRELIST = ["Action & Adventure", "Crime", "Drama", "Mystery", "Sci-Fi & Fantasy", "War & Politics"]
  PLATFORMLIST = ["Amazon Prime", "BBC One", "Disney+", "HBO", "Netflix",]
end
