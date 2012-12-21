# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  password_digest :string(255)
#

class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	attr_accessible(:email, :name, :password, :password_confirmation) 
	
	has_secure_password
	has_many(:microposts, dependent: :destroy)
  has_many :games_created, foreign_key: :user_a_id, class_name: 'Game'
  has_many :games_joined, foreign_key: :user_b_id, class_name: 'Game'
	
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	
	validates(:name, presence: true, length: { maximum: 50 })
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
	validates(:password, presence: true, length: { minimum: 6 })
	validates(:password_confirmation, presence: true)
	
	def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end
	
	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end