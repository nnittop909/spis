module SpSessions
	class DocumentsController < ApplicationController

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			if @sp_session.update(document_params)
				redirect_to sp_session_url(@sp_session), notice: "Documents saved successfully uploaded."
			end
		end

		private

		def document_params
			params.require(:sp_session).permit(:file, :signatory_file)
		end
	end
end