class User < ApplicationRecord
	has_secure_password

	before_save :downcase_nickname, :downcase_email

	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w\d]+@[\w\d]+\.[\w]+\z/ }
	validates :nickname, uniqueness: true, length: {maximum: 40}, format: { with: /\A[a-z_]+\z/ } 
	validates :header_color, format: { with: /\A#[a-f0-9]{6}\z/i }

	private 

	def downcase_nickname
		nickname.downcase!
	end 	

	def downcase_email
    email.downcase!
  end
end
