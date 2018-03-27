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

}
config.fog_directory  = 'artists-db'
config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end

require_all 'app'
