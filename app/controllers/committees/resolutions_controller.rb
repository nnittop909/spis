module Committees
	class ResolutionsController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@resolutions = @committee.resolutions.order(:number, :asc)
		end
	end
end