class Chat < ApplicationRecord
    belongs_to :owner, :class_name => 'User'
    belongs_to :guest, :class_name => 'User'

    has_many :messages
end
