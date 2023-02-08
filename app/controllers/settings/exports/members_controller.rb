module Settings
	module Exports
		class MembersController < ApplicationController

			def index
				@members = Member.order(full_name: :asc).all
			  respond_to do |format|
		      format.xlsx { render xlsx: "index", disposition: 'inline', filename: "Members.xlsx" }
		    end
			end
		end
	end
end