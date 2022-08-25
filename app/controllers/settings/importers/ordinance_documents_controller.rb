module Settings
	module Importers
		class OrdinanceDocumentsController < ApplicationController

			def create
				@ordinance_document = Imports::OrdinanceDocumentsImporter.new(import_params).upload!
				redirect_to settings_url, notice: "Documents are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_ordinance_documents_importer).permit(files: [])		
			end
		end
	end
end