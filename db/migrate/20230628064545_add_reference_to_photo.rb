class AddReferenceToPhoto < ActiveRecord::Migration[7.0]
  def change
    add_reference :photos, :users, foreign_keys: true
  end
end
