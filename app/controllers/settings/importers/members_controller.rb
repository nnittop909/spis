module Settings
	module Importers
		class MembersController < ApplicationController

			def create
				@members_import = Imports::MembersImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Members are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_members_importer).permit(:file)		
			end
		end
	end
end