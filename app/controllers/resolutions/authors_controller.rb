module Resolutions
	class AuthorsController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@members = @resolution.authors.all
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.create(authorship_params)
			respond_to do |format|
	      if @authorship.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Author saved.' }
	        format.json { render :show, status: :created, location: resolutions_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @authorship.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find(params[:id])
			respond_to do |format|
	      if @authorship.update(authorship_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Author updated.' }
	        format.json { render :show, status: :updated, location: resolutions_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @authorship.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find(params[:id])
			@authorship.destroy
			redirect_to resolution_url(id: @resolution.id), notice: 'Author deleted!'
		end

		private

		def authorship_params
			params.require(:authorship).permit(
				:role, :author_id, :author_type
			)
		end
	end
end