module Meetings
	class DocumentsController < ApplicationController

		def new
			@meeting = Meeting.find(params[:meeting_id])
			@document = @meeting.documents.new
		end

		def create
			@meeting = Meeting.find(params[:meeting_id])
			@document = @meeting.documents.create(document_params)
			if @document.save
				redirect_to meeting_url(@meeting), notice: "Document saved successfully uploaded."
			else
				render :new
			end
		end

		def destroy
			@meeting = Meeting.find(params[:meeting_id])
			@document = @meeting.documents.find(params[:id])
			@document.destroy
			redirect_to meeting_url(@meeting), notice: 'Document deleted!'
		end

		private

		def document_params
			params.require(:document).permit(:document_file)
		end
	end
end