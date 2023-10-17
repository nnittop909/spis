module Reports
	class MunicipalOrdinancesController < ApplicationController

		def index
			@from_date = params[:from_date].present? ? params[:from_date] : 999.years.ago
			@to_date = params[:to_date].present? ? params[:to_date] : Date.today
			@series = params[:series].present? ? params[:series] : ""
			@municipality = params[:municipality_id].present? ? Municipality.find(params[:municipality_id]) : []

			@ordinances = MunicipalOrdinances::DefaultOrdinanceFinder.new(
				from_date: @from_date, to_date: @to_date, municipality: @municipality
			).query!

			respond_to do |format|
	      format.html
	      format.pdf do
         	pdf = MunicipalOrdinances::ByDatePdf.new(@ordinances, @municipality, @from_date, @to_date, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "MunicipalOrdinances.pdf"
	      end
	    end
		end
	end
end