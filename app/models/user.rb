class User < ApplicationRecord
  has_many :ads

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  validates :surname, presence: true
  validates :username, length: { minimum:2}, presence: true

  ROLES = %i[booklover banned admin]

  def chats
    Chat.where("owner_id = ? OR guest_id = ?", self.id, self.id)
  end
end
