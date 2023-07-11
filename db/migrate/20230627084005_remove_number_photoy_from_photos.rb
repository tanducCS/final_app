class RemoveNumberPhotoyFromPhotos < ActiveRecord::Migration[7.0]
  def change
    remove_column :photos, :number_photo, :integer
  end
end
