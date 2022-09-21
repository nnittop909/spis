module Resolutions
	class SponsorsController < ApplicationController

		def index
			@resolution = Resolution.find(params[:resolution_id])
			@sponsors = @resolution.committees.all.sort_by(&:start_of_sponsorship)
		end

		def new
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.new
		end

		def create
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.create(sponsorship_params)
			respond_to do |format|
	      if @sponsorship.save
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Sponsor saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find(params[:id])
		end

		def update
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find(params[:id])
			respond_to do |format|
	      if @sponsorship.update(sponsorship_params)
	        format.html { redirect_to resolution_url(id: @resolution.id), notice: "Sponsor updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@resolution = Resolution.find(params[:resolution_id])
			@sponsorship = @resolution.sponsorships.find_by(committee_id: params[:id])
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