class User < ApplicationRecord
	has_secure_password

	has_many :questions, dependent: :delete_all
	has_many :authored_questions, class_name: 'Question', foreign_key: 'author_id', dependent: :nullify

	before_save :downcase_nickname, :downcase_email

	validates :email, presence: true, uniqueness: true, format: { with: /\A[\w\d]+@[\w\d]+\.[\w]+\z/ }
	validates :nickname, uniqueness: true, length: {maximum: 40}, format: { with: /\A[A-Za-z_]+\z/ } 
	validates :header_color, format: { with: /\A#[a-f0-9]{6}\z/i }

	include Gravtastic
	gravtastic(secure: true, filetype: :png, size: 100, default: 'robohash')

	private 

	def downcase_nickname
		nickname.downcase!
	end 	

	def downcase_email
    email.downcase!
  end
end
