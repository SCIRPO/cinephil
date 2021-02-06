class AddViewedtoLikes < ActiveRecord::Migration[6.0]
  def change
    add_column :likes, :viewed, :boolean, :default => false
  end
end
