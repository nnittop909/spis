module Members
	class TermsController < ApplicationController
		respond_to :html, :json, :flash

		def index
			@member = Member.find(params[:member_id])
			@terms = @member.terms.order(start_of_term: :desc)
		end

		def new
			@member = Member.find(params[:member_id])
			@term = @member.terms.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@member = Member.find(params[:member_id])
			@term = @member.terms.new(term_params)
			respond_to do |format|
	      if @term.save
	        format.html { redirect_to member_terms_url(id: @member.id), notice: 'Term created!' }
	        format.json { render :index, status: :created, location: member_terms_url(id: @member.id) }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @term.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
			respond_to do |format|
	      if @term.update(term_params)
	        format.html { redirect_to member_terms_url(id: @member.id), notice: 'Term updated!' }
	        format.json { render :index, status: :updated, location: member_terms_url(id: @member.id) }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @term.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
			@term.destroy
			redirect_to member_terms_url(id: @member.id), notice: 'Term deleted!'
		end

		private

		def term_params
			params.require(:term).permit(
				:position_id, :political_party_id, :start_of_term, :end_of_term,
				:appointment_status
			)
		end
	end
end