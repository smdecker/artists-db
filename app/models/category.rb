class Category < ActiveRecord::Base
	has_many :material_categories
	has_many :materials, :through => :material_categories
	has_many :artwork_categories
	has_many :artworks, :through => :artwork_categories
	belongs_to :user
end