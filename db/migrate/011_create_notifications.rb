class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|

      t.timestamps
      t.references :user
      t.references :ad
      t.integer :displayed
    end

    add_foreign_key :notifications, :users
    add_foreign_key :notifications, :ads
  end
end
