class ReNameTablePhotoBelongTos1 < ActiveRecord::Migration[7.0]
  def change
    rename_table 'photo_belong_to_album', 'photo_belong_to_albums'
  end
end
