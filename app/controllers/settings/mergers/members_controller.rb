module Settings
	module Mergers
		class MembersController < ApplicationController

			def merge
				respond_to do |format|
		      if Merges::MembersMerger.new(mergeables: Member.all).merge!
		        format.html { redirect_to settings_url, notice: "Duplicated Members merging successful!" }
		      else
		        format.html { redirect_to settings_url, notice: "Failed to merge members." }
		      end
		    end
			end
		end
	end
end