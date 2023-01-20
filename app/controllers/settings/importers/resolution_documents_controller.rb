module Settings
	module Importers
		class ResolutionDocumentsController < ApplicationController

			def create
				@resolution_document = Imports::ResolutionDocumentsImporter.new(import_params).upload!
				redirect_to settings_url, notice: "Documents are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_resolution_documents_importer).permit(files: [])		
			end
		end
	end
end