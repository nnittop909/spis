module Committees
	class MembersController < ApplicationController

		def index
			@committee = Committee.find(params[:committee_id])
			@members = CommitteeMember.where(committee_id: @committee.id).where(committee_membership_id: params[:committee_membership_id]).order(:role).all
			@member = @committee.committee_members.new
		end

		def new
			@committee = Committee.find(params[:committee_id])
			@members = CommitteeMember.where(committee_id: @committee.id).where(committee_membership_id: params[:committee_membership_id]).order(:role).all
			@member = @committee.committee_members.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@committee = Committee.find(params[:committee_id])
			@member = @committee.committee_members.new(member_params)
			respond_to do |format|
	      if @member.save
	        format.html { redirect_to committee_members_url(id: @committee.id, committee_membership_id: @committee.current_membership.id), notice: "Committee member added." }
	      	format.json { render :index, status: :created, location: committee_members_url(id: @committee.id, committee_membership_id: @committee.current_membership.id) }
	        format.js
	      else
	        format.html { render :new, status: :unprocessable_entity }
	        format.json { render json: @member.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@committee = Committee.find(params[:committee_id])
			@members = CommitteeMember.where(committee_id: @committee.id).where(committee_membership_id: params[:committee_membership_id]).order(:role).all
			@member = CommitteeMember.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@committee = Committee.find(params[:committee_id])
			@member = CommitteeMember.find(params[:id])
			@member.update(member_params)
			respond_to do |format|
	      if @member.save
	        format.html { redirect_to committee_members_url(id: @committee.id, committee_membership_id: @committee.current_membership.id), notice: "Committee member updated." }
	      	format.json { render :index, status: :created, location: committee_members_url(id: @committee.id, committee_membership_id: @committee.current_membership.id) }
	        format.js
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.json { render json: @member.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@committee = Committee.find(params[:committee_id])
			@member = CommitteeMember.find(params[:id])
			@member.destroy
			redirect_to committee_members_url(id: @committee.id, committee_membership_id: @committee.current_membership.id), notice: 'Member deleted!'
		end

		private

		def member_params
			params.require(:committee_member).permit(
				:committee_id, :committee_membership_id, :member_id, :role
			)
		end

	end
end