require './config/environment'

class ApplicationController < Sinatra::Base

	configure do
		set :public_folder, 'public'
		set :views, 'app/views'
		enable :sessions
		set :session_secret, "secret"
	end

	get '/' do
		if !logged_in?
			erb :login
		else
			erb :welcome
		end
	end

	post 'login' do
		user = User.find_by(username: params[:username])
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect to "/"
		else
			redirect to "/"
		end
	end

	get '/logout' do
    if !logged_in?
      erb :login
    else
      session.clear
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
		if params[:username].empty? || params[:password].empty?

			redirect to "/signup"
		else
				user = User.new(username: params[:username], password: params[:password])
			if user.save
				session[:user_id] = user.id
				redirect to "/"
			else

				redirect to "/signup"
			end
		end
	end

	helpers do
		def logged_in?
			!!current_user
		end

		def current_user
			@current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
		end
	end

end
