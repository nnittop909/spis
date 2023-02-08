module Settings
	module Exports
		class ResolutionsController < ApplicationController

			def index
				@resolutions = Resolution.all.sort_by(&:parsed_number).reverse
				respond_to do |format|
		      format.xlsx { render xlsx: "index", disposition: 'inline', filename: "Resolutions.xlsx" }
		    end
			end
		end
	end
end