class CreateLikePhoto < ActiveRecord::Migration[7.0]
  def change
    create_table :like_photos
    add_reference :like_photos, :user, foreign_keys: true
    add_reference :like_photos,:photo,foreign_keys: true
  end
end
