class ArtworkController < ApplicationController
	get '/artworks' do
    if !logged_in?
      redirect to "/"
    else
      @user = current_user

      erb :"artworks/index"
    end
  end 

  get '/artworks/new' do
		if !logged_in?
			redirect to "/"
		else
      @user = current_user

			erb :"artworks/new_artwork"
		end
	end
end