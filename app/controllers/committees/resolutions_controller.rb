module Committees
	class ResolutionsController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@results = @committee.sponsored_resolutions.sort_by(&:parsed_number).reverse
			@resolutions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
		end
	end
end