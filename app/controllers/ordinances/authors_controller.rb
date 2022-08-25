module Ordinances
	class AuthorsController < ApplicationController

		def index
			@ordinance = Ordinance.find(params[:ordinance_id])
			@members = @ordinance.authors.all
		end

		def new
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.new
		end

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.create(authorship_params)
			respond_to do |format|
	      if @authorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Author saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find(params[:id])
		end

		def update
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find(params[:id])
			respond_to do |format|
	      if @authorship.update(authorship_params)
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Author updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find_by(member_id: params[:id])
			@authorship.destroy
			redirect_to ordinance_url(id: @ordinance.id), notice: 'Author deleted!'
		end

		private

		def authorship_params
			params.require(:authorship).permit(
				:role, :polymorphic_author
			)
		end
	end
end