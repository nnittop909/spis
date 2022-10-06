class ResolutionsController < ApplicationController

	def index
		if params[:search].present?
			@results = Resolution.search(params[:search]).all.sort_by(&:parsed_number).reverse
		elsif params[:year].present?
			@results = StageableByYear.new(year: params[:year], stageable_type: "Resolution").query!
		else
			@results = Resolution.all.sort_by(&:parsed_number).reverse
		end
    @resolutions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@resolution = ResolutionProcessor.new
	end

	def create
		@resolution = ResolutionProcessor.new(create_params)
		if @resolution.process!
			redirect_to resolutions_url, notice: "Resolution saved!"
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
			:number, 
			:title, 
			:date, 
			:remarks,
			:category_id
		)
	end

	def create_params
		params.require(:resolution_processor).permit(
			:number, 
			:title, 
			:date, 
			:remarks,
			:category_id, 
			:date_approved,
			:effectivity_date,
			:same_as_date_approved,
			:stage_id
		)
	end
end