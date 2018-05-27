class ChatMigration < ActiveRecord::Migration[5.1]
  def change

    create_table :chats do |t|

      t.timestamps
      
      t.references :owner
      t.references :guest
    end

    add_foreign_key :chats, :users, column: :owner_id, primary_key: :id
    add_foreign_key :chats, :users, column: :guest_id, primary_key: :id

    create_table :messages do |t|

      t.timestamps
      t.string :text
      t.boolean :read
      t.column :from, :integer, default: 0

      t.references :chat

    end

    add_foreign_key :messages, :chats


    
  end
end