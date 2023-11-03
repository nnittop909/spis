class MunicipalOrdinancesController < ApplicationController

	def index
		if params[:search].present?
			@results = MunicipalOrdinance.search(params[:search]).order(year_and_number: :desc).all
		else
			@results = MunicipalOrdinance.query(query_params(params))
		end
    @municipal_ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def show
		@municipal_ordinance = MunicipalOrdinance.find(params[:id])
	end

	def edit
		@municipal_ordinance = MunicipalOrdinance.find(params[:id])
		respond_to do |format|
	    format.html
	    format.js
	  end
	end

	def update
		@municipal_ordinance = MunicipalOrdinance.find(params[:id])
		respond_to do |format|
      if @municipal_ordinance.update(municipal_ordinance_params)
        format.html { redirect_to municipal_ordinance_url(id: @resolution.id), notice: 'Municipal Ordinance updated.' }
        format.json { render :show, status: :updated, location: municipal_ordinance_url }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @municipal_ordinance.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
	end

	def destroy
		@municipal_ordinance = MunicipalOrdinance.find(params[:id])
		@municipal_ordinance.destroy
		redirect_to municipal_ordinances_url, notice: 'Municipal Ordinance deleted!'
	end

	private

	def municipal_ordinance_params
		params.require(:municipal_ordinance).permit(
			:number, :municipality_id, :keyword, :date_approved
		)
	end

	def query_params(params)
		{ year: params[:year], 
			from_date: params[:from_date], 
			to_date: params[:to_date], 
			municipality_id: params[:municipality_id] 
		}
	end
end