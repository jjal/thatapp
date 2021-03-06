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
	attr_accessible(:email, :name, :password, :password_confirmation, :expert)
	
	has_secure_password
	has_many :microposts, dependent: :destroy
  has_many :games_created, foreign_key: :user_a_id, class_name: 'Game'
  has_many :games_joined, foreign_key: :user_b_id, class_name: 'Game'
	
	before_save { |user| user.email = email.downcase }
	before_save :create_remember_token
	
	validates(:name, presence: true, length: { maximum: 50 })
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false })
	validates(:password, presence: true, length: { minimum: 6 })
	validates(:password_confirmation, presence: true)
	
	def random_other_user
    rand_user = nil
    while(rand_user.nil? or rand_user == self or rand_user.admin? or rand_user.expert?) do    
      offset = rand(User.count)
      rand_user = User.first(:offset => offset)
    end
    return rand_user
  end
	
	private

		def create_remember_token
			self.remember_token = SecureRandom.urlsafe_base64
		end
end
