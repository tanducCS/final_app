class RemoveSomeColumn < ActiveRecord::Migration[7.0]
  def change
    remove_column :albums, :text, :string
    remove_column :photos, :text, :string
    add_column :photos, :image_url, :string
  end
end
