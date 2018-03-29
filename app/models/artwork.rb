class Artwork < ActiveRecord::Base
	has_many :artwork_materials
	has_many :materials, :through => :artwork_materials
	has_many :artwork_categories
	has_many :categories, :through => :artwork_categories
	belongs_to :user

	extend CarrierWave::Mount
	mount_uploader :file, Uploader
end