module Settings
	module Exports
		class CommitteesController < ApplicationController

			def index
				@committees = Committee.order(name: :asc).all
			  respond_to do |format|
		      format.xlsx { render xlsx: "index", disposition: 'inline', filename: "Committees.xlsx" }
		    end
			end
		end
	end
end