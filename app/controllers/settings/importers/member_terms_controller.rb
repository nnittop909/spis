module Settings
	module Importers
		class MemberTermsController < ApplicationController

			def create
				@member_terms_import = Imports::MemberTermsImporter.new(import_params).parse_records!
				redirect_to settings_url, notice: "Member terms are successfully uploaded."
			end

			private
			def import_params
				params.require(:imports_member_terms_importer).permit(:file)		
			end
		end
	end
end