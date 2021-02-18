class AddViewableTypeToViewings < ActiveRecord::Migration[6.0]
  def change
    add_column :viewings, :viewable_type, :string
    rename_column :viewings, :episode_id, :viewable_id
  end
end
