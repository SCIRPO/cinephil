class CreateSeasons < ActiveRecord::Migration[6.0]
  def change
    create_table :seasons do |t|
      t.string :title
      t.integer :season_number
      t.text :synopsis
      t.references :serie, null: false, foreign_key: true

      t.timestamps
    end
  end
end
