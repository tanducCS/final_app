class AddReferencetoBelong < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :photo_belong_to_users, :users, column: :user_id
    add_foreign_key :photo_belong_to_users, :photos, column: :photo_id

    add_foreign_key :photo_belong_tos, :photos, column: :photo_id
    add_foreign_key :photo_belong_tos, :albums, column: :album_id
  end
end
