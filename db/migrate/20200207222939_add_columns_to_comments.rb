class AddColumnsToComments < ActiveRecord::Migration[6.0]
  def change
    add_column :comments, :quake_name, :string
    add_column :comments, :quake_mag, :integer
  end
end
