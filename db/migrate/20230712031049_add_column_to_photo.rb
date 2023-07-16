class AddColumnToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_column :photos, :is_belong_to_album, :boolean, default: false
  end
end
