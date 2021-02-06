class ChangeGenreTypeinSeries < ActiveRecord::Migration[6.0]
  def change
    remove_column :series, :genre
    add_column :series, :genres, :string, array: true
  end
end
