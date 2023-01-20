class MinutesController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Minute.search(params[:search]).order(date: :desc)
		else
			@results = Minute.query(query_params(params))
		end
    @minutes = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@minute = Minute.new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@minute = Minute.new(minute_params)
		respond_to do |format|
      if @minute.save
        format.html { redirect_to minutes_url, notice: 'Minute created!' }
        format.json { render :index, status: :created, location: minutes_url }
        format.js
      else
        format.html { render :new }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def edit
		@minute = Minute.find(params[:id])
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@minute = Minute.find(params[:id])
		respond_to do |format|
      if @minute.update(minute_params)
        format.html { redirect_to minute_url(@minute), notice: 'Minute updated!' }
        format.json { render :show, status: :updated, location: minute_url(@minute) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @minute.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
	end

	def show
		@minute = Minute.find(params[:id])
	end

	private
	def query_params(params)
		{ from_date: params[:from_date], 
			to_date: params[:to_date], 
			minute_type: params[:minute_type] 
		}
	end

	def minute_params
		params.require(:minute).permit(
			:title, 
			:date, 
			:minute_type
		)
	end
end