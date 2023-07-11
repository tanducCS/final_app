class Addforeignkey1 < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :on_follows, :users, column: :followee_id
  end
end
