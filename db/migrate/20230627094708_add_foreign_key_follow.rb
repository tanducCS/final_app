class AddForeignKeyFollow < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :on_follows, :users, column: :follower_id
    change_column :on_follows, :followee_id, "bigint USING followee_id::bigint"

  end
end
