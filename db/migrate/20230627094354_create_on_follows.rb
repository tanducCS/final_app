class CreateOnFollows < ActiveRecord::Migration[7.0]
  def change
    create_table :on_follows do |t|
      t.bigint :follower_id
      t.string :followee_id

      t.timestamps
    end
  end
end
