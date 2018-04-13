class MaterialController < ApplicationController
	get '/materials' do
    if !logged_in?
      redirect to "/"
    else
      category_by_material
      erb :"materials/index"
    end
  end

  get '/materials/recently-added' do
    if !logged_in?
      redirect to "/"
    else
      erb :"materials/recently_added"
    end
  end 

  get '/materials/categories/:slug' do
    if !logged_in?
      redirect to "/"
    else
      @category = Category.find_by_slug(params[:slug])
      erb :'categories/materials'
    end
  end

  get '/materials/new' do
		if !logged_in?
			redirect to "/"
		else
      category_by_artwork
      category_by_material
			erb :"materials/new_material"
		end
	end

	post '/materials' do
    @material = current_user.materials.build(params[:material]) 

    if params["category"]["name"].empty? && params[:material][:category_ids].nil?
    	flash[:message] = "Please input a category."
      redirect to '/materials/new'
    elsif params["material"]["name"].empty?
      flash[:message] = "Please input a name."
      redirect to '/materials/new'
    elsif !params["category"]["name"].empty?
      @material.categories << Category.new(params[:category])
    else
      @material.category_ids = params[:material][:category_ids]
    end         

    if @material.save
      redirect to "/materials"
    end
  end

  get '/materials/:slug' do
    if !logged_in?
      redirect to "/"
    else

      if @current_user.materials.find_by_slug(params[:slug]) == nil
        @material = Material.find_by_slug(params[:slug])
        category_by_material
        erb :"materials/show"
      else
        @material = @current_user.materials.find_by_slug(params[:slug])
        category_by_material
        erb :"materials/show"
      end
    end
  end

  get '/materials/:slug/edit' do
    if !logged_in?
      redirect to "/"
    else
    	category_by_artwork
      category_by_material

      if @current_user.materials.find_by_slug(params[:slug]) == nil
        flash[:message] = "The user you are currently signed in as cannot edit this material."

        @material = Material.find_by_slug(params[:slug])
        redirect to "/materials/#{@material.slug}"
      else
        @material = @current_user.materials.find_by_slug(params[:slug])
        erb :"materials/edit"
      end
    end
  end

  patch '/materials/:slug' do
    @material = Material.find_by_slug(params[:slug])

    if params["category"]["name"].empty? && params[:material][:category_ids].nil?
    	flash[:message] = "Please input a category."
      redirect to '/materials/new'
    elsif !params["category"]["name"].empty?
      @material.categories << Category.new(params[:category])
    else
      @material.category_ids = params[:material][:category_ids]
      @material.category_ids = params[:material][:artwork_ids]
    end 

    @material.update(params[:material])
    redirect to "/materials/#{@material.slug}"
  end

  delete '/materials/:slug/delete' do
    if !logged_in?
      redirect to "/"
    else     
      if @current_user.materials.find_by_slug(params[:slug]) == nil
        flash[:message] = "The user you are currently signed in as cannot delete this material."
        
        @material = Material.find_by_slug(params[:slug])
        redirect to "/materials/#{@material.slug}"
      else
        @material = @current_user.materials.find_by_slug(params[:slug])

        @material.destroy
        redirect to "/materials"
      end
    end
  end

end