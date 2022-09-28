module Resolutions
	class DocumentsController < ApplicationController

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@document = @resolution.create_document(document_params)
			if @document.save
				redirect_to resolution_url(@resolution), notice: "Document saved successfully uploaded."
			end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@document = @resolution.document
			@document.destroy
			redirect_to resolution_url(@resolution), notice: "Document deleted!"
		end

		private
		def document_params
			params.require(:document).permit(:document_file)
		end
	end
end