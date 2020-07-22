class Article < ApplicationRecord
	belongs_to :user
	has_many :comments, dependent: :destroy
	has_many :likes, dependent: :destroy
	validates :title, presence: true, length: {maximum: 20}
	validates :description, presence: true
	validates :user_id, presence: true
end