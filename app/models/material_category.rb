class MaterialCategory < ActiveRecord::Base
	belongs_to :material
	belongs_to :category
end