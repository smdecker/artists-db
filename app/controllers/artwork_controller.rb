class ArtworkController < ApplicationController
	get '/artworks' do
    if !logged_in?
      redirect to "/"
    else
      @user = current_user
      @artwork = Artwork.find_by_id(params[:id])
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

  post '/artworks' do

    @artwork = current_user.artworks.build(params[:artwork])       

    if @artwork.save
      redirect to "/artworks"
    end
  end

end