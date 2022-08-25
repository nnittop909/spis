module Members
	class OrdinancesController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@sorted = @member.authored_ordinances.sort_by(&:joined_number).reverse
			@ordinances = Kaminari.paginate_array(@sorted).page(params[:page]).per(30)
		end
	end
end