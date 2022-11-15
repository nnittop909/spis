module Reports
	class MinutesController < ApplicationController

		def index
			@from_date = params[:from_date].present? ? params[:from_date] : 999.years.ago
			@to_date = params[:to_date].present? ? params[:to_date] : Date.today
			@minute_type = params[:minute_type].present? ? params[:minute_type] : []

			@minutes = Minute.query(query_params(params))
			respond_to do |format|
	      format.html
	      format.pdf do
	      	if @minutes.present?
	      		if params[:minute_type].present?
		      		pdf = Minutes::ByTypePdf.new(@minutes, @minute_type, @from_date, @to_date, view_context)
		          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Minutes.pdf"
		        else
		        	pdf = Minutes::ByDateRangePdf.new(@minutes, @from_date, @to_date, view_context)
		          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Minutes.pdf"
		        end
	      	else
	      		pdf = Minutes::ByDateRangePdf.new(@minutes, @from_date, @to_date, view_context)
		        send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Minutes.pdf"
	        end
	      end
	    end
		end

		private
		def query_params(params)
			{ from_date: params[:from_date], 
				to_date: params[:to_date], 
				minute_type: params[:minute_type] 
			}
		end
	end
end