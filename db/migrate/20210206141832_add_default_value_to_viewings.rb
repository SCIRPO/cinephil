class AddDefaultValueToViewings < ActiveRecord::Migration[6.0]
  def change
    change_column :viewings, :rating, :integer, :default => 0
  end
end
