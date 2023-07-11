class NotNullValuetoTables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :email, false
    change_column_null :users, :gender, false
    change_column_null :users, :active, false
    change_column_null :users, :password, false

    change_column_null :photos, :title, false
    change_column_null :photos, :sharing_mode, false
    change_column_null :photos, :description, false
    change_column_null :photos, :users_id, false
    change_column_null :photos, :image_url, false

    change_column_null :albums, :title, false
    change_column_null :albums, :sharing_mode, false
    change_column_null :albums, :description, false
    change_column_null :albums, :users_id, false

  end
end
