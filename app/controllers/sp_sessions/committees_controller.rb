module SpSessions
	class CommitteesController < ApplicationController

		def new
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee = @sp_session.committee_events.new
		end

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee = @sp_session.committee_events.create(committee_event_params)
			if @committee.save
				redirect_to sp_session_url(@sp_session), notice: "Committee added."
			else
				render :new
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee = @sp_session.committee_events.find(params[:id])
			@committee.destroy
			redirect_to sp_session_url(@sp_session), notice: 'Committee deleted!'
		end

		private

		def committee_event_params
			params.require(:committee_event).permit(:committee_id)
		end
	end
end