class CreateBookmarks < ActiveRecord::Migration[6.0]
  def change
    create_table :bookmarks do |t|
      t.string :quake_db_id
      t.string :place
      t.string :dateAndTime
      t.integer :mag
      t.belongs_to :user

      t.timestamps
    end
  end
end
