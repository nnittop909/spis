module SpSessions
	class ResolutionsController < ApplicationController

		def new
			@sp_session = SpSession.find(params[:sp_session_id])
			@resolution = @sp_session.eventable_resolutions.new
		end

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			@resolution = @sp_session.eventable_resolutions.create(resolution_params)
			if @resolution.save
				redirect_to sp_session_url(@sp_session), notice: "Considered resolution added."
			else
				render :new
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@resolution = @sp_session.eventable_resolutions.find(params[:id])
			@resolution.destroy
			redirect_to sp_session_url(@sp_session), notice: 'Considered resolution deleted!'
		end

		private

		def resolution_params
			params.require(:eventable_resolution).permit(:resolution_id)
		end
	end
end