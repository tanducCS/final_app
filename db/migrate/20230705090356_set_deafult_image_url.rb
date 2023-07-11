class SetDeafultImageUrl < ActiveRecord::Migration[7.0]
  def change
    change_column_default(:photos, :image_url, from: nil, to: "image.png")
  end
end
