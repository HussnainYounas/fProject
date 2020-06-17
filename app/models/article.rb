class Article < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 4, maximum: 8}
	validates :description, presence: true
end
