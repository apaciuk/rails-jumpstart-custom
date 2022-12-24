class User < ApplicationRecord
  after_initialize :set_default_role, if: :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :omniauthable

  has_one_attached :avatar
  has_person_name
  has_noticed_notifications

  has_many :notifications, as: :recipient, dependent: :destroy
  has_many :services

# Roles, add other roles as required
  enum role: {
    user: 0,
    member: 1
  }
  
  private 

  def set_default_role
    self.role ||= :user
  end 

  # Example user from_omniauth method not actioned.
  def self.from_omniauth(auth) 
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.username = auth.info.username   # assuming the user model has a username
		  user.email = auth.info.email
		  user.password = Devise.friendly_token[0,20]
      user.avatar.attach(io: open(auth.info.image), filename: "#{auth.info.username}.jpg")
	  end
  end

end
