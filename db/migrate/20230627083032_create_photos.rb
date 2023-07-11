class CreatePhotos < ActiveRecord::Migration[7.0]
  def change
    create_table :photos do |t|
      t.string :title
      t.timestamp :create_day
      t.string :sharing_mode
      t.integer :number_photo
      t.string :description
      t.string :text

      t.timestamps
    end
  end
end
