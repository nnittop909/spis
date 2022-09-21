module Resolutions
	class AuthorsController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@members = @resolution.authors.all
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.new
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.create(authorship_params)
			respond_to do |format|
	      if @authorship.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Author saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find(params[:id])
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find(params[:id])
			respond_to do |format|
	      if @authorship.update(authorship_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Author updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@authorship = @resolution.authorships.find_by(member_id: params[:id])
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