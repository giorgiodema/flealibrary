class User < ApplicationRecord
  #upload user image using carrierwave
  mount_uploader :image, ImageUploader
  
  has_many :ads, dependent: :destroy
  
  has_many :notifications, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
         #:confirmable, :recoverable

  #validazione di attributi
  validates :name, presence: true
  validates :surname, presence: true
  validates :username, length: { minimum:2}, presence: true
  validates :radius, presence: true
  #inserito un validate per il cap, controllo tramite funzione
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

  #in public c'è un file contenente tutti i cap dei comuni italiani
  def check_cap
    regex = /#{cap}/
    File.open "#{Rails.public_path}/cap_comuni_italiani.txt" do |f|
      f.each_line do |line|
        if line =~ regex #=~ server per vedere se corrisponde alla espressione regolare
          return
        end
      end
    end
    #se non trova corrispondenza aggiunge il messaggio agli errori
    errors.add(:cap, "Enter a valid CAP")
  end

end
