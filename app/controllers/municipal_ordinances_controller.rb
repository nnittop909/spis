class MunicipalOrdinancesController < ApplicationController

	def index
		if params[:search].present?
			@results = MunicipalOrdinance.search(params[:search]).order(year_and_number: :desc).all
		else
			@results = MunicipalOrdinance.query(query_params(params))
		end
    @municipal_ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	private
	def query_params(params)
		{ year: params[:year], 
			from_date: params[:from_date], 
			to_date: params[:to_date], 
			municipality_id: params[:municipality_id] 
		}
	end
end