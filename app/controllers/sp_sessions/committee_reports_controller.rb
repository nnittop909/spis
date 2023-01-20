module SpSessions
	class CommitteeReportsController < ApplicationController

		def new
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee_report = @sp_session.committee_reports.new
		end

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee_report = @sp_session.committee_reports.create(committee_report_params)
			if @committee_report.save
				redirect_to sp_session_url(@sp_session), notice: "Committee report saved successfully uploaded."
			else
				render :new
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@committee_report = @sp_session.committee_reports.find(params[:id])
			@committee_report.destroy
			redirect_to sp_session_url(@sp_session), notice: 'Committee report deleted!'
		end

		private

		def committee_report_params
			params.require(:committee_report).permit(
				:date, :report_number, :document_file, :committee_id
			)
		end
	end
end