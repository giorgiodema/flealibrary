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

    def to?
        if self.from=="o"
            return self.chat.guest
        else
            return self.chat.owner
        end
    end

    def set_from (username)
        if self.chat.owner.username == username
            self.from = "o"
        else
            self.from = "g"
        end
    end
end
