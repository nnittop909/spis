module Committees
	class TermsController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@terms = @committee.committee_memberships.all.order(start_of_term: :desc)
		end

		def new
			@committee = Committee.find(params[:committee_id])
			@term = Committees::TermProcessor.new
		end

		def create
			@committee = Committee.find(params[:committee_id])
			@term = Committees::TermProcessor.new(term_params)
			respond_to do |format|
	      if @term.process!
	        format.html { redirect_to committee_terms_url(id: @committee.id), notice: "Term created." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.find(params[:id])
			@term_processor = Committees::TermProcessor.new("id" => @term.id)
		end

		def update
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.find(params[:id])
			@term_processor = Committees::TermProcessor.new(term_params.merge("id" => @term.id))
			respond_to do |format|
	      if @term_processor.update!
	        format.html { redirect_to committee_terms_url(id: @committee.id), notice: "Term updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@committee = Committee.find(params[:committee_id])
			@term = CommitteeMembership.find(params[:id])
			@term.destroy
			redirect_to committee_terms_url(id: @committee.id), notice: 'Term deleted!'
		end

		private

		def term_params
			params.require(:committees_term_processor).permit(
				:name, :start_of_term, :end_of_term, :active, :committee_id
			)
		end
	end
end