class ChangePlatformTypeInSeries < ActiveRecord::Migration[6.0]
  def change
    remove_column :series, :platform
    add_column :series, :platforms, :string, array: true
  end
end
