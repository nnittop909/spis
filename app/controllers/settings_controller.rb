class SettingsController < ApplicationController

	def index
		@political_parties = PoliticalParty.all
		@terms = Term.all
		@positions = Position.all
		@members_import = Imports::MembersImporter.new
		@member_terms_import = Imports::MemberTermsImporter.new

		@committees_import = Imports::CommitteesImporter.new
		@memberships_import = Imports::MembershipsImporter.new
		@committee_merger = Merges::CommitteeMerger.new

		@ordinances_import = Imports::OrdinancesImporter.new
		@ordinance_authors_import = Imports::OrdinanceAuthorsImporter.new
		@ordinance_sponsors_import = Imports::OrdinanceSponsorsImporter.new
		@ordinance_document = Imports::OrdinanceDocumentsImporter.new

		@resolutions_import = Imports::ResolutionsImporter.new
		@resolution_authors_import = Imports::ResolutionAuthorsImporter.new
		@resolution_document = Imports::ResolutionDocumentsImporter.new

	end
end