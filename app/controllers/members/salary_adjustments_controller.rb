module Members
	class SalaryAdjustmentsController < ApplicationController
		respond_to :html, :json, :flash

		def index
			@member = Member.find(params[:member_id])
			@salary_adjustments = @member.salary_adjustments.joins(:term).order(start_of_term: :desc)
			@step_increments = @member.step_increments.joins(:term).order(start_of_term: :desc)
		end

		def new
			@member = Member.find(params[:member_id])
			@salary_adjustment = @member.salary_adjustments.new
		end

		def create
			@member = Member.find(params[:member_id])
			@salary_adjustment = @member.salary_adjustments.create(salary_adjustment_params)
			if @member.save
				redirect_to member_salary_adjustments_url(id: @member.id), notice: "Salary Adjustment saved."
	    else
	    	render :new
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@salary_adjustment = SalaryAdjustment.find(params[:id])
		end

		def update
			@member = Member.find(params[:member_id])
			@salary_adjustment = SalaryAdjustment.find(params[:id])
      if @salary_adjustment.update(salary_adjustment_params)
        redirect_to member_salary_adjustments_url(id: @member.id), notice: "Salary adjustment updated."
      else
        render :edit
      end
		end

		def destroy
			@member = Member.find(params[:member_id])
			@salary_adjustment = SalaryAdjustment.find(params[:id])
			@salary_adjustment.destroy
			redirect_to member_salary_adjustments_url(id: @member.id), notice: 'Salary adjustment deleted!'
		end

		private

		def salary_adjustment_params
			params.require(:salary_adjustment).permit(
				:dated_at, :effectivity_date, :term_id, :monthly_salary,
				:adjusted_salary, :adjustment, :member_id
			)
		end
	end
end