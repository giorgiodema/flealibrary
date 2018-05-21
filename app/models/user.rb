class User < ApplicationRecord

    def chats
        Chat.where("owner_id = ? OR guest_id = ?", self.id, self.id)
    end
end
