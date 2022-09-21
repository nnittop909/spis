module Ordinances
	class SponsorsController < ApplicationController

		def index
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsors = @ordinance.committees.all.sort_by(&:start_of_sponsorship)
		end

		def new
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.new
		end

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.create(sponsorship_params)
			respond_to do |format|
	      if @sponsorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Sponsor saved." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find(params[:id])
		end

		def update
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find(params[:id])
			respond_to do |format|
	      if @sponsorship.update(sponsorship_params)
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Sponsor updated." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find_by(committee_id: params[:id])
			@sponsorship.destroy
			redirect_to ordinance_url(id: @ordinance.id), notice: 'Sponsor deleted!'
		end

		private

		def sponsorship_params
			params.require(:sponsorship).permit(
				:role, :sponsor_id, :sponsor_type
			)
		end
	end
end