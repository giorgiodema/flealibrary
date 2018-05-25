class CreateAds < ActiveRecord::Migration[5.1]
  def change
    create_table :ads do |t|
      t.integer :list_type
      t.string :book_title
      t.string :book_authors
      t.string :link_to_coverbook
      t.string :publisher
      t.string :identifier
      t.references :user
      t.timestamps
    end
  end
end
