module Ordinances
	class ProvincialsController < ApplicationController

		def index
			if params[:search].present?
				@results = Ordinance.search(params[:search]).all.sort_by(&:parsed_number).reverse
			else
				@results = Ordinance.query(query_params(params))
			end
	    @ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
		end

		private
		def query_params(params)
			{ year: params[:year], 
				from_date: params[:from_date], 
				to_date: params[:to_date], 
				category_id: params[:category_id] 
			}
		end
	end
end