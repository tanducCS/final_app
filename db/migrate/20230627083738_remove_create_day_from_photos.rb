class RemoveCreateDayFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :create_day, :timestamp
  end
end
