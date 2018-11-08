class AddHostIdToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :host_id, :string
  end
end
