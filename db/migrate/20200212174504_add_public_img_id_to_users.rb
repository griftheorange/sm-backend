class AddPublicImgIdToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :public_img_id, :string
  end
end
