module Ordinances
	class StagesController < ApplicationController

		def index
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stages = @ordinance.stagings.order(:date)
		end

		def new
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stage = @ordinance.stagings.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stage = @ordinance.stagings.new(stage_params)
			respond_to do |format|
	      if @stage.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Stage created." }
	        format.json { render :show, status: :created, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :new }
	        format.json { render json: @stage.errors, status: :unprocessable_entity }
        	format.js { render :new }
	      end
	    end
		end

		def edit
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stage = @ordinance.stagings.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stage = @ordinance.stagings.find(params[:id])
			respond_to do |format|
	      if @stage.update(stage_params)
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Stage updated." }
	        format.json { render :show, status: :updated, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @stage.errors, status: :unprocessable_entity }
        	format.js { render :edit }
	      end
	    end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@stage = @ordinance.stagings.find(params[:id])
			@stage.destroy
			redirect_to ordinance_url(id: @ordinance.id), notice: 'Stage deleted!'
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