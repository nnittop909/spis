module Reports
	class OrdinancesController < ApplicationController

		def index
			@from_date = params[:from_date].present? ? params[:from_date] : 999.years.ago
			@to_date = params[:to_date].present? ? params[:to_date] : Date.today
			@category = params[:category_id].present? ? Category.find(params[:category_id]) : []

			if params[:author_id].present?
				@author = Member.find(params[:author_id])
				@ordinances = Ordinances::AuthoredOrdinanceFinder.new(
					author: @author, category: @category, from_date: @from_date, to_date: @to_date
				).query!
			elsif params[:sponsor_id].present?
				@sponsor = Committee.find(params[:sponsor_id])
				@ordinances = Ordinances::SponsoredOrdinanceFinder.new(
					sponsor: @sponsor, category: @category, from_date: @from_date, to_date: @to_date
				).query!
			else
				@ordinances = Ordinances::DefaultOrdinanceFinder.new(
					from_date: @from_date, to_date: @to_date, category: @category
				).query!
			end

			respond_to do |format|
	      format.html
	      format.pdf do
      		if params[:author_id].present?
      			pdf = Ordinances::ByAuthorPdf.new(@ordinances, @category, @author, @from_date, @to_date, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "AuthoredOrdinances.pdf"
      		elsif params[:sponsor_id].present?
	      		pdf = Ordinances::BySponsorPdf.new(@ordinances, @category, @sponsor, @from_date, @to_date, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "SponsoredOrdinances.pdf"
	        else
	         	pdf = Ordinances::ByDatePdf.new(@ordinances, @category, @from_date, @to_date, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Ordinances.pdf"
	        end
	      end
	    end
		end
	end
end