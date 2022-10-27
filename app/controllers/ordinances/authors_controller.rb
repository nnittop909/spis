module Ordinances
	class AuthorsController < ApplicationController

		def index
			@ordinance = Ordinance.find(params[:ordinance_id])
			@members = @ordinance.authors.all
		end

		def new
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.create(authorship_params)
			respond_to do |format|
	      if @authorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Author created." }
	        format.json { render :show, status: :created, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :new }
	        format.json { render json: @authorship.errors, status: :unprocessable_entity }
        	format.js { render :new }
	      end
	    end
		end

		def edit
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find(params[:id])
			respond_to do |format|
	      if @authorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Author updated." }
	        format.json { render :show, status: :updated, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @authorship.errors, status: :unprocessable_entity }
        	format.js { render :edit }
	      end
	    end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@authorship = @ordinance.authorships.find(params[:id])
			@authorship.destroy
			redirect_to ordinance_url(id: @ordinance.id), notice: 'Author deleted!'
		end

		private

		def authorship_params
			params.require(:authorship).permit(
				:role, :author_id, :author_type
			)
		end
	end
end