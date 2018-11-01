class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.references :group, foreign_key: true
      t.string :playlist_id
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
