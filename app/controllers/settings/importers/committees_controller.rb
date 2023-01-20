module Settings
	module Importers
		class CommitteesController < ApplicationController

			def create
				@committees_import = Imports::CommitteesImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Committees are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_committees_importer).permit(:file)		
			end
		end
	end
end