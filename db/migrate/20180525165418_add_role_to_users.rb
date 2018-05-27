class AddRoleToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :role, :string, :default => User::ROLES[0].to_s
  end
end
