class User < ApplicationRecord
  #upload user image using carrierwave
  mount_uploader :image, ImageUploader
  
  has_many :ads

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
         #:confirmable, :recoverable

  #validazione di attributi
  validates :name, presence: true
  validates :surname, presence: true
  validates :username, length: { minimum:2}, presence: true
  #validates :cap, length: {is: 5, message: "needs 5 integer"}, presence: true, format: { with: /\d{5}/, message: "needs 5 integer" }
  validates :radius, presence: true
  validate :check_cap

  validates_uniqueness_of :username

  validates_integrity_of  :image
  validates_processing_of :image

  #ruoli utente
  ROLES = %i[booklover banned admin superadmin]

  def chats
    Chat.where("owner_id = ? OR guest_id = ?", self.id, self.id)
  end

  def self.setRole(id, new_role)
    user = User.find(id)
    user.role = new_role
    user.save
  end

  def check_cap
    regex = /#{cap}/
    File.open "#{Rails.public_path}/cap_comuni_italiani.txt" do |f|
      f.each_line do |line|
        if line =~ regex
          return
        end
      end
    end
    errors.add(:cap, "valid cap")
  end

end
