class AddSomeDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :users, :gender, ""
  end
end
