module Committees
	class ResolutionsController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@resolutions = @committee.sponsored_resolutions.order(number: :asc).page(params[:page]).per(30)
		end
	end
end