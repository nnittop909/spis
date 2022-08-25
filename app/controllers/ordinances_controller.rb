class OrdinancesController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Ordinance.search(params[:search]).all.sort_by(&:joined_number).reverse
		else
			@results = Ordinance.all.sort_by(&:joined_number).reverse
		end
    @ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@ordinance = Ordinance.new
	end

	def create
		@ordinance = Ordinance.create(ordinance_params)
		respond_to do |format|
      if @ordinance.save
        format.html { redirect_to ordinance_url(@ordinance), notice: "Ordinance saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
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
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def show
		@ordinance = Ordinance.find(params[:id])
		@authors = @ordinance.authors
		@sponsors = @ordinance.sponsors
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
end