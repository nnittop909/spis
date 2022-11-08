module Settings
	class CategoriesController < ApplicationController

		def index
			@categories = Category.all
		end

		def new
			@category = Category.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@category = Category.new(category_params)
			respond_to do |format|
	      if @category.save
	        format.html { redirect_to settings_categories_url, notice: 'Catefory created!' }
	        format.json { render :index, status: :created, location: settings_categories_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@category = Category.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@category = Category.find(params[:id])
			respond_to do |format|
	      if @category.update(category_params)
	        format.html { redirect_to settings_url, notice: 'Category updated!' }
	        format.json { render :index, status: :updated, location: settings_categories_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @category.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		private

		def category_params
			params.require(:category).permit(:name)
		end
	end
end