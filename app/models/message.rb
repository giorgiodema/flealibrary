class Message < ApplicationRecord
    belongs_to :chat
    enum from: [:o,:g]

    def from?
        if self.from=="o"
            return self.chat.owner
        else
            return self.chat.guest
        end
    end
end
