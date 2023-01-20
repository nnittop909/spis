module Settings
	module Importers
		class OrdinanceSponsorsController < ApplicationController

			def create
				@ordinance_sponsors_import = Imports::OrdinanceSponsorsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Sponsors are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_ordinance_sponsors_importer).permit(:file)		
			end
		end
	end
end