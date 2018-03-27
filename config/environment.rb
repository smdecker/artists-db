ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => 'gallery.db'
)

CarrierWave.configure do |config|
config.fog_credentials = {
:provider               => 'AWS',
:region					=> 'us-east-2',
:aws_access_key_id      => 'AKIAIIEPQZAMDDZDPH4A',
:aws_secret_access_key  => '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',
}
config.fog_directory  = 'artists-db'
config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end

require_all 'app'
