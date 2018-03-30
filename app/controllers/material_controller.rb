class MaterialController < ApplicationController
	get '/materials' do
    if !logged_in?
      redirect to "/"
    else
      @user = current_user
      @material = Material.find_by_id(params[:id])
      erb :"materials/index"
    end
  end 

  get '/materials/new' do
		if !logged_in?
			redirect to "/"
		else
      @user = current_user

			erb :"materials/new_material"
		end
	end

	post '/materials' do

    @material = current_user.materials.build(params[:material]) 

    if params["category"]["name"].empty? && params[:material][:category_ids].nil?

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
    if logged_in?
      @material = Material.find_by_slug(params[:slug])

      erb :"materials/show"
    else
      redirect to "/"
    end
  end

  get '/materials/:slug/edit' do
    if !logged_in?
      redirect to "/"
    else
      @user = current_user
      @material = Material.find_by_slug(params[:slug])

      if !current_user.materials.include?(@material)
        redirect to "/materials/#{@material.slug}"
      else
        erb :"materials/edit"
      end
    end
  end

  patch '/materials/:slug' do
    @material = Material.find_by_slug(params[:slug])

    @material.update(params[:material])
    redirect to "/materials/#{@material.slug}"
  end

  delete '/materials/:slug/delete' do
    if logged_in?
      @material = Material.find_by_slug(params[:slug])
      @material.destroy

      redirect to "/materials"
    else
      redirect to "/login"
    end
  end
 

end