module Settings
	module Exports
		class OrdinancesController < ApplicationController

			def index
				@ordinances = Ordinance.all.sort_by(&:parsed_number).reverse
			  respond_to do |format|
		      format.xlsx { render xlsx: "index", disposition: 'inline', filename: "Ordinances.xlsx" }
		    end
			end
		end
	end
end