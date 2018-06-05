class Favourite < ApplicationRecord
    belongs_to :user
    validates :user_id, :presence => true
    validates_associated :user
    belongs_to :ad
    validates :ad_id, :presence => true
    validates_associated :ad
end
