class AddLocateOptionToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :cap, :string, null: false
    add_column :users, :radius, :string, null: false
  end
end
