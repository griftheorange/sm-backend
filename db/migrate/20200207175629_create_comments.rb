class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :commented_quake, null: false, foreign_key: true
      t.string :date_posted
      t.text :content

      t.timestamps
    end
  end
end
