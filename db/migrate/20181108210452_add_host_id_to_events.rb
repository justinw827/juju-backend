class AddHostIdToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :host_id, :string
  end
end
