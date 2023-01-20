module Ordinances
	module Authorships
		class AuthorsController < ApplicationController

			def new
				@ordinance = Ordinance.find(params[:ordinance_id])
				@authors = Member.all - @ordinance.authors
				@authorship = Ordinances::AuthorProcessor.new
				respond_to do |format|
		      format.html
		      format.js
		    end
			end

			def create
				@ordinance = Ordinance.find(params[:ordinance_id])
				@authorship = Ordinances::AuthorProcessor.new(authorship_params)
				respond_to do |format|
		      if @authorship.process!
		        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Principal authors added to ordinance ##{@ordinance.number}." }
		        format.json { render :show, status: :created, location: ordinance_url(id: @ordinance.id) }
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
				params.require(:ordinances_author_processor).permit(
					:role, :ordinance_id, member_ids: []
				)
			end
		end
	end
end