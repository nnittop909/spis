module Committees
	class MembersController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@members = CommitteeMember.where(committee_id: @committee.id).where(committee_membership_id: params[:committee_membership_id]).order(:role).all
		end

		def new
			@committee = Committee.find(params[:committee_id])
			@member = @committee.committee_members.new
		end

		def create
			@committee = Committee.find(params[:committee_id])
			@member = @committee.committee_members.create(member_params)
			respond_to do |format|
	      if @member.save
	        format.html { redirect_to committee_members_url(id: @committee.id), notice: "Committee member added." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def edit
			@committee = Committee.find(params[:committee_id])
			@member = CommitteeMember.find(params[:id])
		end

		def update
			@committee = Committee.find(params[:committee_id])
			@member = CommitteeMember.find(params[:id])
			@member.update(member_params)
			respond_to do |format|
	      if @member.save
	        format.html { redirect_to committee_members_url(id: @committee.id), notice: "Committee member updated." }
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		def destroy
			@committee = Committee.find(params[:committee_id])
			@member = CommitteeMember.find(params[:id])
			@member.destroy
			redirect_to committee_members_url(id: @committee.id), notice: 'member deleted!'
		end

		private

		def member_params
			params.require(:committee_member).permit(
				:committee_id, :committee_membership_id, :member_id, :role
			)
		end

	end
end