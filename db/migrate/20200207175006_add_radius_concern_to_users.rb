class AddRadiusConcernToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :radius_concern, :integer 
  end
end
