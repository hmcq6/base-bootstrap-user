# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  password_digest        :string(255)
#  email_verified         :boolean          default(FALSE)
#  auth_token             :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  password_reset_token   :string(255)
#  password_reset_sent_at :datetime
#

class User < ActiveRecord::Base
	has_secure_password
	attr_accessible :email, :password, :password_confirmation, :first_name, :last_name, :user_name, :guest

  before_create :set_defaults
  
	validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :user_name, presence: true, uniqueness: { case_sensitive: false }, format: { with: /^[a-z0-9\-_]+$/i }
                                                                                    
	validates :password, length: { minimum: 6 }
	#validates :password_confirmation

	before_save	{ email.downcase! }
	before_create { generate_token(:auth_token) }

	has_many :posts

  
  def set_defaults
    self.guest ||= true
  end

	def send_password_reset
		generate_token(:password_reset_token)
		self.password_reset_sent_at = Time.zone.now
		save!(validate: false)
		UserMailer.password_reset(self).deliver
	end

	def password_reset_expired?
		password_reset_sent_at < 2.hours.ago
	end

	def generate_token(column)
		begin
			self[column] = SecureRandom.urlsafe_base64
		end while User.exists?(column => self[column])
	end

end
