module Reports
	class MemberProfileController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			respond_to do |format|
	      format.html
	      format.pdf do
      		pdf = MemberProfilePdf.new(@member, view_context)
          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "Member Profile.pdf"
	      end
	    end
		end
	end
end