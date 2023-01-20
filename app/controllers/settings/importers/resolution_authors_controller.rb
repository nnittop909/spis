module Settings
	module Importers
		class ResolutionAuthorsController < ApplicationController

			def create
				@resolution_authors_import = Imports::ResolutionAuthorsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Authors are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_resolution_authors_importer).permit(:file)		
			end
		end
	end
end