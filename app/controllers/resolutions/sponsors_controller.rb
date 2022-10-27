module Resolutions
	class SponsorsController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@sponsors = @resolution.sponsors.all
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.create(sponsorship_params)
			respond_to do |format|
	      if @sponsorship.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Sponsor saved.' }
	        format.json { render :show, status: :created, location: resolutions_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find(params[:id])
			respond_to do |format|
	      if @sponsorship.update(sponsorship_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: 'Sponsor updated.' }
	        format.json { render :show, status: :updated, location: resolutions_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find(params[:id])
			@sponsorship.destroy
			redirect_to resolution_url(id: @resolution.id), notice: 'Sponsor deleted!'
		end

		private

		def sponsorship_params
			params.require(:sponsorship).permit(
				:role, :sponsor_id, :sponsor_type
			)
		end
	end
end