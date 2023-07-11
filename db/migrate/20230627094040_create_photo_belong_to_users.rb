class CreatePhotoBelongToUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :photo_belong_to_users do |t|
      t.bigint :photo_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
