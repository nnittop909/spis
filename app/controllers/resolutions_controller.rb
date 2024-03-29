class ResolutionsController < ApplicationController

	def index
		if params[:search].present?
			@results = Resolution.search(params[:search]).all.sort_by(&:parsed_number).reverse
		else
			@results = Resolution.query(query_params(params))
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

	def query_params(params)
		{ year: params[:year], 
			from_date: params[:from_date], 
			to_date: params[:to_date], 
			category_id: params[:category_id] 
		}
	end

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
			:stage_id,
			:municipality_id,
			:keyword,
			:ordinance_number
		)
	end
end