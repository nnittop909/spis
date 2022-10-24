module Members
	class ServiceOathsController < ApplicationController
		respond_to :html, :json, :flash

		def create
			@member = Member.find(params[:member_id])
			@service_oath = @member.update(service_oath_params)
			if @member.save
				redirect_to member_url(@member), notice: "Service oath uploaded."
	    else
	    	render :new
	    end
		end

		def update
			@member = Member.find(params[:member_id])
			@service_oath = @member.service_oath
      if @service_oath.update(service_oath_params)
        redirect_to member_url(@member), notice: "Service oath updated."
      else
        render :edit
      end
		end

		def destroy
			@member = Member.find(params[:member_id])
			@service_oath = @member.service_oath
			@service_oath.purge
			redirect_to member_url(@member), notice: 'Service oath deleted!'
		end

		private

		def service_oath_params
			params.require(:member).permit(
				:service_oath
			)
		end
	end
end