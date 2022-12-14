module Resolutions
	class StagesController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@stages = @resolution.stagings.order(:date)
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.new(stage_params)
			respond_to do |format|
	      if @stage.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Stage saved.' }
	        format.json { render :show, status: :created, location: resolutions_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @stage.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.find(params[:id])
			respond_to do |format|
	      if @stage.update(stage_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Stage updated.' }
	        format.json { render :show, status: :updated, location: resolutions_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @stage.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.find(params[:id])
			@stage.destroy
			redirect_to resolution_url(id: @resolution.id), notice: 'Stage deleted!'
		end

		private

		def stage_params
			params.require(:staging).permit(
				:date, :effectivity_date, :stage_id,
				:same_as_date_approved
			)
		end
	end
end