class User < ActiveRecord::Base
	has_secure_password
	has_many :materials
	has_many :artworks
	has_many :categories
	validates :username, presence: true
	validates :password, presence: true
end
