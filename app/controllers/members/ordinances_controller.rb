module Members
	class OrdinancesController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@ordinances = @member.ordinances.order(number: :asc).page(params[:page]).per(30)
		end
	end
end