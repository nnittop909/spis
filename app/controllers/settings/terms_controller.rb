module Settings
	class TermsController < ApplicationController

		def new
			@term = Term.new
		end

		def create
			@term = Term.create(term_params)
			if @term.save
				redirect_to settings_url, notice: "Term created!"
			else
				render :new
			end
		end

		def edit
			@term = Term.find(params[:id])
		end

		def update
			@term = Term.find(params[:id])
			@term.update(term_params)
			if @term.save
				redirect_to settings_url, notice: "Term updated!"
			else
				render :edit
			end
		end

		private

		def term_params
			params.require(:term).permit(
				:start_of_term, :end_of_term
			)
		end
	end
end