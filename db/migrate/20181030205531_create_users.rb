class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :spotify_id

      t.timestamps
    end
  end
end
