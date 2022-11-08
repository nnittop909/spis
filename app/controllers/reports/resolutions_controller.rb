module Reports
	class ResolutionsController < ApplicationController

		def index
			@from_date = params[:from_date].present? ? params[:from_date] : 999.years.ago
			@to_date = params[:to_date].present? ? params[:to_date] : Date.today

			if params[:author_id].present?
				@author = Member.find(params[:author_id])
				@resolutions = Resolutions::AuthoredResolutionFinder.new(
					author: @author, from_date: @from_date, to_date: @to_date
				).query!
			end

			if params[:sponsor_id].present?
				@sponsor = Committee.find(params[:sponsor_id])
				@resolutions = Resolutions::SponsoredResolutionFinder.new(
					sponsor: @sponsor, from_date: @from_date, to_date: @to_date
				).query!
			end

			@resolutions = Resolutions::DefaultResolutionFinder.new(
				from_date: @from_date, to_date: @to_date
			).query!

			respond_to do |format|
	      format.html
	      format.pdf do
	      	if @resolutions.present?
	      		if params[:author_id].present?
	      			pdf = Resolutions::ByAuthorPdf.new(@resolutions, @category, @author, @from_date, @to_date, view_context)
		          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "AuthoredResolutions.pdf"
	      		elsif params[:sponsor_id].present?
		      		pdf = Resolutions::BySponsorPdf.new(@resolutions, @category, @sponsor, @from_date, @to_date, view_context)
		          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "SponsoredResolutions.pdf"
		        else
		         	pdf = Resolutions::ByDatePdf.new(@resolutions, @category, @from_date, @to_date, view_context)
		          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Resolutions.pdf"
		        end
	      	else
	      		pdf = Resolutions::ByDatePdf.new(@resolutions, @category, @from_date, @to_date, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Resolutions.pdf"
	        end
	      end
	    end
		end
	end
end