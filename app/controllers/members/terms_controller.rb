module Members
	class TermsController < ApplicationController

		def index
			@member = Member.find(params[:member_id])
			@terms = @member.terms.order(start_of_term: :desc)
		end

		def new
			@member = Member.find(params[:member_id])
			@term = @member.terms.new
		end

		def create
			@member = Member.find(params[:member_id])
			@term = @member.terms.create(term_params)
			respond_to do |format|
	      if @member.save
	        format.html { redirect_to member_terms_url(id: @member.id), notice: "Term saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
		end

		def update
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
			respond_to do |format|
	      if @term.update(term_params)
	        format.html { redirect_to member_terms_url(id: @member.id), notice: "Term updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
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
				:interim
			)
		end
	end
end