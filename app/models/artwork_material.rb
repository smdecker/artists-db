class ArtworkMaterial < ActiveRecord::Base
	belongs_to :artwork
	belongs_to :material
end