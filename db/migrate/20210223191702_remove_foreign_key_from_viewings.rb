class RemoveForeignKeyFromViewings < ActiveRecord::Migration[6.0]
  def change
    remove_foreign_key :viewings, column: "viewable_id"
  end
end
