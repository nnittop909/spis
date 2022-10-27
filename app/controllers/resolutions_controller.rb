class ResolutionsController < ApplicationController

	def index
		if params[:search].present?
			@results = Resolution.search(params[:search]).all.sort_by(&:parsed_number).reverse
		elsif params[:year].present?
			@results = StageableByYear.new(year: params[:year], stageable_type: "Resolution").query!
		elsif params[:category_name].present?
			@results = Resolution.categorize(params[:category_name]).all.sort_by(&:parsed_number).reverse
		else
			@results = Resolution.all.sort_by(&:parsed_number).reverse
		end
    @resolutions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@resolution = ResolutionProcessor.new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@resolution = ResolutionProcessor.new(create_params)
		respond_to do |format|
      if @resolution.process!
        format.html { redirect_to resolutions_url, notice: 'Resolution created!' }
        format.json { render :index, status: :created, location: resolutions_url }
        format.js
      else
        format.html { render :new }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def edit
		@resolution = Resolution.find(params[:id])
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@resolution = Resolution.find(params[:id])
		respond_to do |format|
      if @resolution.update(resolution_params)
        format.html { redirect_to resolution_url(@resolution), notice: "Resolution updated!" }
        format.json { render :show, status: :updated, location: resolution_url(@resolution) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @resolution.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
	end

	def show
		@resolution = Resolution.find(params[:id])
		@authors = @resolution.authors
		@principal_authors = @authors.select{|a| @resolution.authorships.where(author_id: a.id).last.role == "author"}
		@co_authors = @authors.select{|a| @resolution.authorships.where(author_id: a.id).last.role == "co_author"}
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