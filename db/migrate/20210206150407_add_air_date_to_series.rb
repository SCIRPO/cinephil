class AddAirDateToSeries < ActiveRecord::Migration[6.0]
  def change
    add_column :series, :release_date, :date
    remove_column :episodes, :duration
  end
end
