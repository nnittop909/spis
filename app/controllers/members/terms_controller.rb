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
		end

		def create
			@member = Member.find(params[:member_id])
			@term = @member.terms.create!(term_params)
			if @member.save
				redirect_to member_terms_url(id: @member.id), notice: "Term saved."
	    else
	    	render :new
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
		end

		def update
			@member = Member.find(params[:member_id])
			@term = Term.find(params[:id])
      if @term.update(term_params)
        redirect_to member_terms_url(id: @member.id), notice: "Term updated."
      else
        render :edit
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