class ArtworkController < ApplicationController
	get '/artworks' do
    if !logged_in?
      redirect to "/"
    else
      @user = current_user
      category_by_artwork
      @artwork = Artwork.find_by_id(params[:id])
      erb :"artworks/index"
    end
  end 

  get '/artworks/new' do
		if !logged_in?
			redirect to "/"
		else
      @user = current_user
      category_by_artwork
      category_by_material
			erb :"artworks/new_artwork"
		end
	end

  post '/artworks' do

    @artwork = current_user.artworks.build(params[:artwork]) 

    if params["category"]["name"].empty? && params[:artwork][:category_ids].nil?

      redirect to '/artworks/new'
    elsif !params["category"]["name"].empty?
      @artwork.categories << Category.new(params[:category])
    else
      @artwork.category_ids = params[:artwork][:category_ids]
    end         

    if @artwork.save
      redirect to "/artworks"
    end
  end

  get '/artworks/:slug' do
    if logged_in?
      @artwork = Artwork.find_by_slug(params[:slug])

      erb :"artworks/show"
    else
      redirect to "/"
    end
  end

  get '/artworks/:slug/edit' do
    if !logged_in?
      redirect to "/"
    else
      category_by_artwork
      category_by_material
      @user = current_user
      @artwork = Artwork.find_by_slug(params[:slug])

      if !current_user.artworks.include?(@artwork)
        redirect to "/artworks/#{@artwork.slug}"
      else
        erb :"artworks/edit"
      end
    end
  end

  patch '/artworks/:slug' do
    @artwork = Artwork.find_by_slug(params[:slug])

    @artwork.update(params[:artwork])
    redirect to "/artworks/#{@artwork.slug}"
  end  

  delete '/artworks/:slug/delete' do
    if logged_in?
      @artwork = Artwork.find_by_slug(params[:slug])
      @artwork.destroy

      redirect to "/artworks"
    else
      redirect to "/login"
    end
  end

end