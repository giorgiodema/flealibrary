class ChangeUsernameTypeInUsers < ActiveRecord::Migration[5.1]
  def change
    change_column_null :users, :username, :string, false
  end
end
