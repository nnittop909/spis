module Ordinances
	class SponsorsController < ApplicationController

		def index
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsors = @ordinance.committees.all.sort_by(&:start_of_sponsorship)
		end

		def new
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.create(sponsorship_params)
			respond_to do |format|
	      if @sponsorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Sponsor created." }
	        format.json { render :show, status: :created, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :new }
	        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
        	format.js { render :new }
	      end
	    end
		end

		def edit
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find(params[:id])
			respond_to do |format|
	      if @sponsorship.save
	        format.html { redirect_to ordinance_url(id: @ordinance.id), notice: "Sponsor updated." }
	        format.json { render :show, status: :updated, location: ordinance_url(id: @ordinance.id) }
        	format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @sponsorship.errors, status: :unprocessable_entity }
        	format.js { render :edit }
	      end
	    end
		end

		def destroy
			@ordinance = Ordinance.find(params[:ordinance_id])
			@sponsorship = @ordinance.sponsorships.find(params[:id])
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