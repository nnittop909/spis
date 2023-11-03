module Resolutions
	class MunicipalOrdinancesController < ApplicationController

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@municipal_ordinance = @resolution.build_municipal_ordinance
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@municipal_ordinance = @resolution.create_municipal_ordinance(municipal_ordinance_params)
			respond_to do |format|
	      if @municipal_ordinance.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Municipal Ordinance saved.' }
	        format.json { render :show, status: :created, location: resolution_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @municipal_ordinance.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@municipal_ordinance = @resolution.municipal_ordinance
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@municipal_ordinance = @resolution.municipal_ordinance
			respond_to do |format|
	      if @municipal_ordinance.update(municipal_ordinance_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Municipal Ordinance updated.' }
	        format.json { render :show, status: :updated, location: resolution_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @municipal_ordinance.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@municipal_ordinance = @resolution.municipal_ordinance
			@municipal_ordinance.destroy
			redirect_to resolution_url(id: @resolution.id), notice: 'Municipal Ordinance deleted!'
		end

		private

		def municipal_ordinance_params
			params.require(:municipal_ordinance).permit(
				:number, :municipality_id, :keyword
			)
		end
	end
end