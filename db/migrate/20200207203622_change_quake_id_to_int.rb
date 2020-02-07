class ChangeQuakeIdToInt < ActiveRecord::Migration[6.0]
  def change
    change_column :commented_quakes, :quake_db_id, :string
  end
end
