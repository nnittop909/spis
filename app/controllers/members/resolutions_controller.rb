module Members
	class ResolutionsController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@results = @member.authored_resolutions.sort_by(&:parsed_number).reverse
			@resolutions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
		end
	end
end