class AddReferenceto < ActiveRecord::Migration[7.0]
  def change
    add_reference :albums, :users, foreign_key: true
  end
end
