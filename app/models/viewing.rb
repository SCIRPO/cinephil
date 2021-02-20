class Viewing < ApplicationRecord
  belongs_to :user
  belongs_to :viewable, polymorphic: true
  delegate :serie, to: :viewable

  def platforms
    if viewable_type == "Serie"
      viewable.platforms
    elsif viewable_type == "Season"
      viewable.serie.platforms
    else
      viewable.season.serie.platforms
    end
  end
end
