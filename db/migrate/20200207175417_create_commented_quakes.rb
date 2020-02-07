class CreateCommentedQuakes < ActiveRecord::Migration[6.0]
  def change
    create_table :commented_quakes do |t|
      t.string :quake_db_id

      t.timestamps
    end
  end
end
