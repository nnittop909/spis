class OrdinancesController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Ordinance.search(params[:search]).all.sort_by(&:parsed_number).reverse
		elsif params[:year].present?
			@results = StageableByYear.new(year: params[:year], stageable_type: "Ordinance").query!
		elsif params[:category_name].present?
			@results = Ordinance.categorize(params[:category_name]).all.sort_by(&:parsed_number).reverse
		else
			@results = Ordinance.all.sort_by(&:parsed_number).reverse
		end
    @ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@ordinance = OrdinanceProcessor.new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@ordinance = OrdinanceProcessor.new(create_params)
		respond_to do |format|
      if @ordinance.process!
        format.html { redirect_to ordinances_url, notice: 'Ordinance created!' }
        format.json { render :index, status: :created, location: ordinances_url }
        format.js
      else
        format.html { render :new }
        format.json { render json: @ordinance.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def edit
		@ordinance = Ordinance.find(params[:id])
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@ordinance = Ordinance.find(params[:id])
		respond_to do |format|
      if @ordinance.update(ordinance_params)
        format.html { redirect_to ordinance_url(@ordinance), notice: 'Ordinance updated!' }
        format.json { render :show, status: :updated, location: ordinance_url(@ordinance) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @ordinance.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
	end

	def show
		@ordinance = Ordinance.find(params[:id])
		@authors = @ordinance.authors
		@principal_authors = @authors.select{|a| @ordinance.authorships.where(author_id: a.id).last.role == "author"}
		@co_authors = @authors.select{|a| @ordinance.authorships.where(author_id: a.id).last.role == "co_author"}
		@sponsors = @ordinance.sponsors
		@stagings = @ordinance.stagings
	end

	private
	def ordinance_params
		params.require(:ordinance).permit(
			:number, 
			:title, 
			:date, 
			:remarks, 
			:category_id
		)
	end

	def create_params
		params.require(:ordinance_processor).permit(
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