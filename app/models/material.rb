class Material < ActiveRecord::Base
	has_many :artwork_materials
	has_many :artworks, :through => :artwork_materials
	has_many :material_categories
	has_many :categories, :through => :material_categories
	belongs_to :user

	extend CarrierWave::Mount
	mount_uploader :file, Uploader
end