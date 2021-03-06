require './config/environment'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
require 'mini_magick'
require 'rack-flash'
require 'uri'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "secret"
		use Rack::Flash
	end

	get '/' do
		if !logged_in?
			erb :login
		else
			erb :welcome
		end
	end

	post '/login' do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to "/"
		else
			flash[:message] = "Please check username and password."
			redirect to "/"
		end
	end

	get '/logout' do
    if !logged_in?
      erb :login
    else
      session.destroy
      redirect to "/"
    end
	end	

	get '/signup' do
		if !logged_in?
			erb :signup
		else
			redirect to "/"
		end
	end

	post '/signup' do
		user = User.new(params)
		if user.save
			session[:user_id] = user.id
			redirect to "/"
		else
			flash[:message] = "You cannot leave any fields blank."
			redirect to "/signup"
		end
	end

	helpers do
		def logged_in?
			!!current_user
		end

		def current_user
  		@current_user ||= User.find(session[:user_id]) if session[:user_id]
		end


		def category_by_artwork
      @artwork_category = []
      @current_user.artworks.each do |artwork|
        artwork.categories.collect do |category|
          @artwork_category << category.id
				end
			end
		end

    def category_by_material
      @material_category = []
      @current_user.materials.each do |material|
        material.categories.collect do |category|
          @material_category << category.id
        end
      end
    end

	end

end
