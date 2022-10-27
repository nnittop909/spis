module Committees
	class TermsController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@terms = @committee.committee_memberships.all.order(start_of_term: :desc)
		end

		def new
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.new(term_params)
			respond_to do |format|
	      if @term.save
	        format.html { redirect_to committee_terms_url(id: @committee.id), notice: 'Term created!' }
	        format.json { render :index, status: :created, location: committee_terms_url(id: @committee.id) }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @term.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@committee = Committee.find(params[:committee_id])
			@term = @committee.committee_memberships.find(params[:id])
			respond_to do |format|
	      if @term.update(term_params)
	        format.html { redirect_to committee_terms_url(id: @committee.id), notice: 'Term updated!' }
	        format.json { render :index, status: :updated, location: committee_terms_url(id: @committee.id) }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @term.errors, status: :unprocessable_entity }
	        format.js { render :edit }
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
			params.require(:committee_membership).permit(
				:name, :start_of_term, :end_of_term, :committee_id
			)
		end
	end
end