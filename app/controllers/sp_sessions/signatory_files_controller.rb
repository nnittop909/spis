module SpSessions
	class SignatoryFilesController < ApplicationController

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			if @sp_session.update(document_params)
				redirect_to sp_session_url(@sp_session), notice: "Documents successfully uploaded."
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@signatory_file = @sp_session.signatory_file
			ActiveStorage::Attachment.find(@signatory_file.id).purge
			redirect_to sp_session_url(@sp_session), notice: 'Signatory file deleted!'
		end

		private

		def document_params
			params.require(:sp_session).permit(:signatory_file)
		end
	end
end