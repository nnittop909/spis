module Settings
	module Mergers
		class CommitteesController < ApplicationController

			def new
				@committee_merger = Merges::CommitteeMerger.new
				respond_to do |format|
		      format.html
		      format.js
		    end
			end

			def create
				@committee_merger = Merges::CommitteeMerger.new(committee_params)
				respond_to do |format|
		      if @committee_merger.merge!
		        format.html { redirect_to settings_committees_url, notice: "Merge success!." }
		        format.json { render :index, status: :created, location: settings_committees_url }
	        	format.js
		      else
		        format.html { render :new }
		        format.json { render json: @committee_merger.errors, status: :unprocessable_entity }
		        format.js { render :new }
		      end
		    end
			end

			private

			def committee_params
				params.require(:merges_committee_merger).permit(
					:merge_from_id, :merge_to_id
				)
			end
		end
	end
end