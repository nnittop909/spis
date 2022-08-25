module Committees
	class OrdinancesController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@ordinances = @committee.ordinances.order(:number, :asc)
		end
	end
end