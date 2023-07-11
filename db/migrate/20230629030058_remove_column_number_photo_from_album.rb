class RemoveColumnNumberPhotoFromAlbum < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :number_photo, :integer
  end
end
