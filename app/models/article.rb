class Article < ActiveRecord::Base
	belongs_to :user
	validates :title, presence: true, length: {minimum: 4, maximum: 8}
	validates :description, presence: true
	validates :user_id, presence: true
end
