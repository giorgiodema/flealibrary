class CreateFavourites < ActiveRecord::Migration[5.1]
  def change
    create_table :favourites do |t|
      t.references :user
      t.references :ad      
      t.timestamps
    end
  end
end
