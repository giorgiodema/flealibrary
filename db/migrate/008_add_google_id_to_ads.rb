class AddGoogleIdToAds < ActiveRecord::Migration[5.1]
  def change
    add_column :ads, :google_id, :string
  end
end
