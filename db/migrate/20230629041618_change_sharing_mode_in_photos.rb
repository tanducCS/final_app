class ChangeSharingModeInPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :sharing_mode, :string
    remove_column :albums, :sharing_mode, :string
    add_column :photos, :sharing_mode, :integer,default: 0, null: false
    add_column :albums, :sharing_mode, :integer, default:0, null: false
  end
end
