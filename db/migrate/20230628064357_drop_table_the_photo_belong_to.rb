class DropTableThePhotoBelongTo < ActiveRecord::Migration[7.0]
  def change
    drop_table :photo_belong_to_users
  end
end
