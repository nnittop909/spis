module Settings
	class ResolutionsController < ApplicationController

		def index
			@resolutions_import = Imports::ResolutionsImporter.new
			@resolution_authors_import = Imports::ResolutionAuthorsImporter.new
			@resolution_document = Imports::ResolutionDocumentsImporter.new

			authorize @resolutions_import, policy_class: Settings::ResolutionPolicy	
			authorize @resolution_authors_import, policy_class: Settings::ResolutionPolicy	
			authorize @resolution_document, policy_class: Settings::ResolutionPolicy	
		end
	end
end