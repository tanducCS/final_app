class CreateTableLikeAlbum < ActiveRecord::Migration[7.0]
  def change
    create_table :like_albums
    add_reference :like_albums, :user, foreign_keys: true
    add_reference :like_albums,:album,foreign_keys: true
  end
end
