class ChangeNameUserId < ActiveRecord::Migration[7.0]
  def change
    rename_column :photos, :users_id, :user_id
    rename_column :albums, :users_id, :user_id
  end
end
