module SpSessions
	class FilesController < ApplicationController

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			if @sp_session.update(document_params)
				redirect_to sp_session_url(@sp_session), notice: "Documents successfully uploaded."
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@file = @sp_session.file
			ActiveStorage::Attachment.find(@file.id).purge
			redirect_to sp_session_url(@sp_session), notice: 'Document deleted!'
		end

		private

		def document_params
			params.require(:sp_session).permit(:file)
		end
	end
end