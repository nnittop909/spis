module Reports
	class CommitteesController < ApplicationController

		def index
			@year = params[:year] ? params[:year] : Date.today.year
			@sp_term = current_office.sp_terms.term_at(@year)
			@number_ordinal = @sp_term.number_ordinal
			@office = current_office
			@committees = Committees::QueryByTerm.new(year: @year).query!
			respond_to do |format|
	      format.html
	      format.pdf do
	      	if @members.present?
	      		pdf = StandingCommitteesPdf.new(@committees, @sp_term, @year, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "#{@number_ordinal}StandingCommittees.pdf"
	      	else
	      		pdf = StandingCommitteesPdf.new(@committees, @sp_term, @year, view_context)
	          send_data pdf.render, type: "application/pdf", disposition: 'inline', file_name: "#{@number_ordinal}StandingCommittees.pdf"
	        end
	      end
	    end
		end
	end
end