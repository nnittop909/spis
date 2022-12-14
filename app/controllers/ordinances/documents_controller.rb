module Ordinances
	class DocumentsController < ApplicationController

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@document = @ordinance.documents.create(document_params)
			if @document.save
				redirect_to ordinance_url(@ordinance), notice: "Document successfully uploaded."
			else
				render :new
			end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@document = @ordinance.documents.find(params[:id])
			@document.destroy
			redirect_to ordinance_url(@ordinance), notice: 'Document deleted!'
		end

		private

		def document_params
			params.require(:document).permit(:document_file)
		end
	end
end