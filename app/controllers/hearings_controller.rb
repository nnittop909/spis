class HearingsController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Hearing.search(params[:search]).order(title: :desc).all
		else
			@results = Hearing.order(title: :desc).all
		end
    @hearings = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@hearing = Hearing.new
	end

	def create
		@hearing = Hearing.create(hearing_params)
		respond_to do |format|
      if @hearing.save
        format.html { redirect_to hearing_url(@hearing), notice: "Hearing saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@hearing = Hearing.find(params[:id])
	end

	def update
		@hearing = Hearing.find(params[:id])
		respond_to do |format|
      if @hearing.update(hearing_params)
        format.html { redirect_to hearing_url(@hearing), notice: "Hearing updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def show
		@hearing = Hearing.find(params[:id])
		@documents = @hearing.documents
	end

	private
	def hearing_params
		params.require(:hearing).permit(
			:date, 
			:title, 
			:description
		)
	end
end