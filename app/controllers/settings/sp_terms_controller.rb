module Settings
	class SpTermsController < ApplicationController

		def index
			@sp_terms = SpTerm.order(ordinal_number: :desc).all
		end

		def new
			@office = current_office
			@sp_term = SpTerm.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@office = current_office
			@sp_term = @office.sp_terms.new(sp_term_params)
			respond_to do |format|
	      if @sp_term.save
	        format.html { redirect_to settings_sp_terms_url, notice: 'SP Term created!' }
	        format.json { render :index, status: :created, location: settings_sp_terms_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @sp_term.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@office = current_office
			@sp_term = SpTerm.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@office = current_office
			@sp_term = SpTerm.find(params[:id])
			@sp_term.update(sp_term_params)
			respond_to do |format|
	      if @sp_term.update(sp_term_params)
	        format.html { redirect_to settings_sp_terms_url, notice: 'SP Term updated!' }
	        format.json { render :index, status: :updated, location: settings_sp_terms_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @sp_term.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		private

		def sp_term_params
			params.require(:sp_term).permit(
				:start_of_term, :end_of_term, :ordinal_number
			)
		end
	end
end