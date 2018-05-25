class Ad < ApplicationRecord
    belongs_to :user
    validates :user_id :presence => true
    validates_associated :user
    validates_inclusion_of :list_type, in: 0..2
end
