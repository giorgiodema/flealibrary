class Message < ApplicationRecord
    belongs_to :chat
    enum from: [:o,:g]
end
