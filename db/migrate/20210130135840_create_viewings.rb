class CreateViewings < ActiveRecord::Migration[6.0]
  def change
    create_table :viewings do |t|
      t.integer :rating
      t.references :user, null: false, foreign_key: true
      t.references :episode, null: false, foreign_key: true

      t.timestamps
    end
  end
end
