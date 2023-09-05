module Settings
	module Exports
		class ResolutionsController < ApplicationController

			def index
				@from_date = params[:from_date].present? ? params[:from_date] : 999.years.ago
				@to_date = params[:to_date].present? ? params[:to_date] : Date.today
				@category = params[:category_id].present? ? Category.find(params[:category_id]) : []

				if params[:author_id].present?
					@author = Member.find(params[:author_id])
					@resolutions = Resolutions::AuthoredResolutionFinder.new(
						author: @author, category: @category, from_date: @from_date, to_date: @to_date
					).query!
				elsif params[:sponsor_id].present?
					@sponsor = Committee.find(params[:sponsor_id])
					@resolutions = Resolutions::SponsoredResolutionFinder.new(
						sponsor: @sponsor, category: @category, from_date: @from_date, to_date: @to_date
					).query!
				else
					@resolutions = Resolutions::DefaultResolutionFinder.new(
						from_date: @from_date, to_date: @to_date, category: @category
					).query!
				end
				respond_to do |format|
		      format.xlsx { render xlsx: "index", disposition: 'inline', filename: "Resolutions.xlsx" }
		    end
			end
		end
	end
end