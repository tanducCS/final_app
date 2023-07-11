class RemoveCreateDayFromAlbums < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :create_day, :timestamp
  end
end
