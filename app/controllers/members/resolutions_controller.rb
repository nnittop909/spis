module Members
	class ResolutionsController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@resolutions = @member.authored_resolutions.order(number: :asc).page(params[:page]).per(30)
		end
	end
end