module SpSessions
	class DocumentsController < ApplicationController

		def create
			@sp_session = SpSession.find(params[:sp_session_id])
			@document = @sp_session.documents.create(document_params)
			if @document.save
				redirect_to sp_session_url(@sp_session), notice: "Document saved successfully uploaded."
			else
				render :new
			end
		end

		def destroy
			@sp_session = SpSession.find(params[:sp_session_id])
			@document = @sp_session.documents.find(params[:id])
			@document.destroy
			redirect_to sp_session_url(@sp_session), notice: 'Document deleted!'
		end

		private

		def document_params
			params.require(:document).permit(:document_file)
		end
	end
end