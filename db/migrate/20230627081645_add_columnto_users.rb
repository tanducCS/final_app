class AddColumntoUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :last_login, :timestamp
    add_column :users, :active, :boolean
    add_column :users, :password, :string
  end
end