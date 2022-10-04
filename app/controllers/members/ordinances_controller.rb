module Members
	class OrdinancesController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@results = @member.authored_ordinances.sort_by(&:parsed_number).reverse
			@ordinances = Kaminari.paginate_array(@results).page(params[:page]).per(30)
		end
	end
end