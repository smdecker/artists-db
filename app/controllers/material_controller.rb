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

end