class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.references :user
      t.references :ad
    end

    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :ads

  end
end
