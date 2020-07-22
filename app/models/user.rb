class User < ApplicationRecord
	has_many :articles, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, uniqueness: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: {with: VALID_EMAIL_REGEX}
	before_save { self.email = email.downcase }
 	has_secure_password
end