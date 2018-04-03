class Material < ActiveRecord::Base
	has_many :artwork_materials
	has_many :artworks, :through => :artwork_materials
	has_many :material_categories
	has_many :categories, :through => :material_categories
	belongs_to :user

	extend CarrierWave::Mount
	mount_uploader :file, Uploader

  def slug
  	name.downcase.gsub(/[^0-9a-z]/i,"-")
  end

  def self.find_by_slug(slug)
    Material.all.find{|material| material.slug == slug}
  end
end