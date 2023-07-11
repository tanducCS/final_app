class CreatePhotoBelongTos < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_belong_tos do |t|
      t.bigint :photo_id
      t.bigint :album_id

      t.timestamps
    end
  end
end
