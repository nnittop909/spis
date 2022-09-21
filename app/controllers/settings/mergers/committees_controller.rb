module Settings
	module Mergers
		class CommitteesController < ApplicationController

			def new
				@committee_merger = Merges::CommitteeMerger.new
			end

			def create
				@committee_merger = Merges::CommitteeMerger.new(committee_params)
				respond_to do |format|
		      if @committee_merger.merge!
		        format.html { redirect_to settings_url, notice: "Merging success!." }
		      else
		        format.html { render :new, status: :unprocessable_entity }
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