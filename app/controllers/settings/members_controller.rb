module Settings
	class MembersController < ApplicationController

		def index
			@members_import = Imports::MembersImporter.new
			@member_terms_import = Imports::MemberTermsImporter.new
			authorize @members_import, policy_class: Settings::MemberPolicy
			authorize @member_terms_import, policy_class: Settings::MemberPolicy
		end
	end
end