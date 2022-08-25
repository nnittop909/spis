module Committees
	class OrdinancesController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@ordinances = @committee.sponsored_ordinances.order(number: :asc).page(params[:page]).per(30)
		end
	end
end