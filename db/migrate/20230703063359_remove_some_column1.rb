class RemoveSomeColumn1 < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :password, type: :string, null: false
    remove_column :users, :admin_id, type: :bigint, null: false

  end
end
