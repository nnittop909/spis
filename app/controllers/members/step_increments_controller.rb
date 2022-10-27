module Members
	class StepIncrementsController < ApplicationController
		respond_to :html, :json, :flash

		def index
			@member = Member.find(params[:member_id])
			@step_increments = @member.step_increments.joins(:term).order(start_of_term: :desc)
			@step_increments = @member.step_increments.joins(:term).order(start_of_term: :desc)
		end

		def new
			@member = Member.find(params[:member_id])
			@step_increment = @member.step_increments.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@member = Member.find(params[:member_id])
			@step_increment = @member.step_increments.new(step_increment_params)
			respond_to do |format|
	      if @step_increment.save
	        format.html { redirect_to member_salary_adjustments_url(member_id: @member.id), notice: 'Step Increment created!' }
	        format.json { render :index, status: :created, location: member_salary_adjustments_url(member_id: @member.id) }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @step_increment.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@step_increment = StepIncrement.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@member = Member.find(params[:member_id])
			@step_increment = StepIncrement.find(params[:id])
			respond_to do |format|
	      if @step_increment.update(step_increment_params)
	        format.html { redirect_to member_salary_adjustments_url(member_id: @member.id), notice: 'Step Increment updated!' }
	        format.json { render :index, status: :updated, location: member_salary_adjustments_url(member_id: @member.id) }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @step_increment.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		def destroy
			@member = Member.find(params[:member_id])
			@step_increment = StepIncrement.find(params[:id])
			@step_increment.destroy
			redirect_to member_salary_adjustments_url(id: @member.id), notice: 'Step Increment deleted!'
		end

		private

		def step_increment_params
			params.require(:step_increment).permit(
				:dated_at, :effectivity_date, :term_id, :salary_prior_to_adjustment,
				:adjusted_salary, :salary_adjustment, :member_id
			)
		end
	end
end