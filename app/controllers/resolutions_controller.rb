class ResolutionsController < ApplicationController

	def index
		if params[:search].present?
			@results = Resolution.search(params[:search]).all.sort_by(&:joined_number).reverse
		else
			@results = Resolution.all.sort_by(&:joined_number).reverse
		end
    @resolutions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@resolution = Resolution.new
	end

	def create
		@resolution = Resolution.create!(resolution_params)
		if @resolution.save
			redirect_to resolutions_url, notice: "Resolution created!"
		else
			render :new
		end
	end

	def edit
		@resolution = Resolution.find(params[:id])
	end

	def update
		@resolution = Resolution.find(params[:id])
		if @resolution.update(resolution_params)
			redirect_to resolution_url(@resolution), notice: "Resolution updated!"
		else
			render :edit
		end
	end

	def show
		@resolution = Resolution.find(params[:id])
		@authors = @resolution.authors
		@sponsors = @resolution.sponsors
	end

	private
	def resolution_params
		params.require(:resolution).permit(
			:number, :title, :date, :remarks,
			:category_id, author_ids: [], documents: []
		)
	end
end