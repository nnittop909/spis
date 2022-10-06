class OrdinancesController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Ordinance.search(params[:search]).all.sort_by(&:parsed_number).reverse
		elsif params[:year].present?
			@results = StageableByYear.new(year: params[:year], stageable_type: "Ordinance").query!
		else
			@results = Ordinance.all.sort_by(&:parsed_number).reverse
		end
    @ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@ordinance = OrdinanceProcessor.new
	end

	def create
		@ordinance = OrdinanceProcessor.new(create_params)
		respond_to do |format|
      if @ordinance.process!
        format.html { redirect_to ordinances_url, notice: "Ordinance saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@ordinance = Ordinance.find(params[:id])
	end

	def update
		@ordinance = Ordinance.find(params[:id])
		respond_to do |format|
      if @ordinance.update(ordinance_params)
        format.html { redirect_to ordinance_url(@ordinance), notice: "Ordinance updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
	end

	def show
		@ordinance = Ordinance.find(params[:id])
		@authors = @ordinance.authors
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