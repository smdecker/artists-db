class ArtworkController < ApplicationController
	get '/artworks' do
    if !logged_in?
      redirect to "/"
    else
      category_by_artwork
      erb :"artworks/index"
    end
  end

  get '/artworks/recently-added' do
    if !logged_in?
      redirect to "/"
    else
      erb :"artworks/recently_added"
    end
  end 

  get '/artworks/categories/:slug' do
    if !logged_in?
      redirect to "/"
    else
      @category = Category.find_by_slug(params[:slug])
      erb :'categories/artworks'
    end
  end

  get '/artworks/new' do
		if !logged_in?
			redirect to "/"
		else
      category_by_artwork
      category_by_material
			erb :"artworks/new_artwork"
		end
	end

  post '/artworks' do
    @artwork = current_user.artworks.build(params[:artwork]) 

    if params["category"]["name"].empty? && params[:artwork][:category_ids].nil?
      flash[:message] = "Please input a category."
      redirect to '/artworks/new'
    elsif params["artwork"]["title"].empty?
      flash[:message] = "Please input a title."
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
    if !logged_in?
      redirect to "/"
    else

      if @current_user.artworks.find_by_slug(params[:slug]) == nil
        @artwork = Artwork.find_by_slug(params[:slug])
        category_by_artwork
        erb :"artworks/show"
      else
        @artwork = @current_user.artworks.find_by_slug(params[:slug])
        category_by_artwork
        erb :"artworks/show"
      end
    end
  end

  get '/artworks/:slug/edit' do
    if !logged_in?
      redirect to "/"
    else
      category_by_artwork
      category_by_material

      if @current_user.artworks.find_by_slug(params[:slug]) == nil
        flash[:message] = "The user you are currently signed in as cannot edit this artwork."

        @artwork = Artwork.find_by_slug(params[:slug])
        redirect to "/artworks/#{@artwork.slug}"
      else
        @artwork = @current_user.artworks.find_by_slug(params[:slug])
        erb :"artworks/edit"
      end
    end
  end

  patch '/artworks/:slug' do
    @artwork = Artwork.find_by_slug(params[:slug])

    if params["category"]["name"].empty? && params[:artwork][:category_ids].nil?
      flash[:message] = "Please input a category."
      redirect to '/artworks/new'
    elsif !params["category"]["name"].empty?
      @artwork.categories << Category.new(params[:category])
    else
      @artwork.category_ids = params[:artwork][:category_ids]
      @artwork.material_ids = params[:artwork][:material_ids]
    end 

    @artwork.update(params[:artwork])
    redirect to "/artworks/#{@artwork.slug}"
  end  

  delete '/artworks/:slug/delete' do
    if !logged_in?
      redirect to "/"
    else
      if @current_user.artworks.find_by_slug(params[:slug]) == nil
        flash[:message] = "The user you are currently signed in as cannot delete this artwork."

        @artwork = Artwork.find_by_slug(params[:slug])
        redirect to "/artworks/#{@artwork.slug}"
      else
        @artwork = @current_user.artworks.find_by_slug(params[:slug])
        
        @artwork.destroy
        redirect to "/artworks"
      end
    end
  end

end