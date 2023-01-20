module SpSessions
	class OrdinancesController < ApplicationController

		def new
			@sp_session = SpSession.find(params[:sp_session_id])
			@ordinance = @sp_session.eventable_ordinances.new
		end

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			@ordinance = @sp_session.eventable_ordinances.create(ordinance_params)
			if @ordinance.save
				redirect_to sp_session_url(@sp_session), notice: "Considered ordinance added."
			else
				render :new
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@ordinance = @sp_session.eventable_ordinances.find(params[:id])
			@ordinance.destroy
			redirect_to sp_session_url(@sp_session), notice: 'Considered ordinance deleted!'
		end

		private

		def ordinance_params
			params.require(:eventable_ordinance).permit(:ordinance_id)
		end
	end
end