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
		end

		def create
			@member = Member.find(params[:member_id])
			@step_increment = @member.step_increments.create!(step_increment_params)
			if @member.save
				redirect_to member_salary_adjustments_url(id: @member.id), notice: "Step increment saved."
	    else
	    	render :new
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@step_increment = StepIncrement.find(params[:id])
		end

		def update
			@member = Member.find(params[:member_id])
			@step_increment = StepIncrement.find(params[:id])
      if @step_increment.update(step_increment_params)
        redirect_to member_salary_adjustments_url(id: @member.id), notice: "Step increment updated."
      else
        render :edit
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