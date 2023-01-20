module Settings
	module Importers
		class ResolutionsController < ApplicationController

			def create
				@resolutions_import = Imports::ResolutionsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Resolutions are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_resolutions_importer).permit(:file)		
			end
		end
	end
end