class User < ActiveRecord::Base
	has_secure_password
	has_many :materials
	has_many :artworks
	has_many :categories
	validates_presence_of :username, :password
end
