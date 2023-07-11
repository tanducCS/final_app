class AddForeignKeyforPhoto < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :photos, :users, column: :user_id
  end
end
