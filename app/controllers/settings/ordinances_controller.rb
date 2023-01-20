module Settings
	class OrdinancesController < ApplicationController
		def index
			@ordinances_import = Imports::OrdinancesImporter.new
			@ordinance_authors_import = Imports::OrdinanceAuthorsImporter.new
			@ordinance_sponsors_import = Imports::OrdinanceSponsorsImporter.new
			@ordinance_document = Imports::OrdinanceDocumentsImporter.new

			authorize @ordinances_import, policy_class: Settings::OrdinancePolicy
			authorize @ordinance_authors_import, policy_class: Settings::OrdinancePolicy	
			authorize @ordinance_sponsors_import, policy_class: Settings::OrdinancePolicy	
			authorize @ordinance_document, policy_class: Settings::OrdinancePolicy	
		end
	end
end