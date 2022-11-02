module Resolutions
	module Authorships
		class CoAuthorsController < ApplicationController

			def new
				@resolution = Resolution.find(params[:resolution_id])
				@authors = Member.all - @resolution.authors
				@authorship = Resolutions::AuthorProcessor.new
				respond_to do |format|
		      format.html
		      format.js
		    end
			end

			def create
				@resolution = Resolution.find(params[:resolution_id])
				@authorship = Resolutions::AuthorProcessor.new(authorship_params)
				respond_to do |format|
		      if @authorship.process!
		        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Co authors added to resolution ##{@resolution.number}." }
		        format.json { render :show, status: :created, location: resolution_url(id: @resolution.id) }
	        	format.js
		      else
		        format.html { render :new }
		        format.json { render json: @authorship.errors, status: :unprocessable_entity }
	        	format.js { render :new }
		      end
		    end
			end

			private

			def authorship_params
				params.require(:resolutions_author_processor).permit(
					:role, :resolution_id, member_ids: []
				)
			end
		end
	end
end