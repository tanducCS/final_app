class ReNameTablePhotoBelongTos < ActiveRecord::Migration[7.0]
  def change
    rename_table 'photo_belong_tos', 'photo_belong_to_album'
  end
end
