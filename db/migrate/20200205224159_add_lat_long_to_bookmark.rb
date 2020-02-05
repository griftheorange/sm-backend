class AddLatLongToBookmark < ActiveRecord::Migration[6.0]
  def change
    add_column :bookmarks, :lat, :integer
    add_column :bookmarks, :long, :integer
  end
end
