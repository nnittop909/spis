module Settings
	class CommitteesController < ApplicationController

		def index
			@committees_import = Imports::CommitteesImporter.new
			@memberships_import = Imports::MembershipsImporter.new
			@committee_merger = Merges::CommitteeMerger.new
		end
	end
end