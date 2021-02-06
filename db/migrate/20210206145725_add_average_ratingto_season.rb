class AddAverageRatingtoSeason < ActiveRecord::Migration[6.0]
  def change
    add_column :seasons, :season_rating, :integer, :default => 0
    add_column :series, :serie_rating, :integer, :default => 0
  end
end
