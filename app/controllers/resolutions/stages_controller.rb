module Resolutions
	class StagesController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@stages = @resolution.stagings.order(:date)
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.new
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.create(stage_params)
			respond_to do |format|
	      if @stage.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Stage saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.find(params[:id])
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@stage = @resolution.stagings.find(params[:id])
			respond_to do |format|
	      if @stage.update(stage_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Stage updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
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
				:date, :effectivity_date, :stage_id
			)
		end
	end
end