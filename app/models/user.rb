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

  # Example other role set method not actioned.
  def set_alt_role
	case role.to_sym
	when :member
		self.role = :member
	else
		self.role = :user
	end
  end
  
  # Example user from_amniauth method not actioned.
  def self.from_omniauth(auth) 
	where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
		user.email = auth.info.email
		user.password = Devise.friendly_token[0,20]
		user.first_name = auth.info.first_name
		user.last_name = auth.info.last_name
		user.avatar.attach(io: open(auth.info.image), filename: "#{auth.info.first_name}_#{auth.info.last_name}.jpg")
	end
   end

end
