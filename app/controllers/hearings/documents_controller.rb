module Hearings
	class DocumentsController < ApplicationController

		def new
			@hearing = Hearing.find(params[:hearing_id])
			@document = @hearing.documents.new
		end

		def create
			@hearing = Hearing.find(params[:hearing_id])
			@document = @hearing.documents.create(document_params)
			if @document.save
				redirect_to hearing_url(@hearing), notice: "Document saved successfully uploaded."
			else
				render :new
			end
		end

		def destroy
			@hearing = Hearing.find(params[:hearing_id])
			@document = @hearing.documents.find(params[:id])
			@document.destroy
			redirect_to hearing_url(@hearing), notice: 'Document deleted!'
		end

		private

		def document_params
			params.require(:document).permit(:document_file)
		end
	end
end