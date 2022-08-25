module Settings
	module Importers
		class MembershipsController < ApplicationController

			def create
				@memberships_import = Imports::MembershipsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Committee Membership are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_memberships_importer).permit(:file)		
			end
		end
	end
end