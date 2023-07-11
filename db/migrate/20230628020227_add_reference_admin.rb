class AddReferenceAdmin < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :admin_id, :bigint
    add_foreign_key :users, :users, column: :admin_id
  end
end
