module Settings
	module Importers
		class OrdinanceAuthorsController < ApplicationController

			def create
				@ordinance_authors_import = Imports::OrdinanceAuthorsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Authors are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_ordinance_authors_importer).permit(:file)		
			end
		end
	end
end