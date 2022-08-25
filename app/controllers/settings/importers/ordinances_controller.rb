module Settings
	module Importers
		class OrdinancesController < ApplicationController

			def create
				@ordinances_import = Imports::OrdinancesImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Ordinances are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_ordinances_importer).permit(:file)		
			end
		end
	end
end