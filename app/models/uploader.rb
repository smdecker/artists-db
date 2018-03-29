class Uploader < CarrierWave::Uploader::Base
	include CarrierWave::MiniMagick

	storage :fog
	def store_dir
	'images'
	end

	version :thumb do
	process :resize_to_fill => [250, 250]
	end

	version :large do
	process :resize_to_fill => [400, 400]
	end

	protected
	def secure_token
	var = :"@#{mounted_as}_secure_token"
	model.instance_variable_get(var) or model.instance_variable_set(var, SecureRandom.uuid)
	end
end