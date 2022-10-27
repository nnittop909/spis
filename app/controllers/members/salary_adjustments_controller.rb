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
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@member = Member.find(params[:member_id])
			@salary_adjustment = @member.salary_adjustments.create(salary_adjustment_params)
			respond_to do |format|
	      if @salary_adjustment.save
	        format.html { redirect_to member_salary_adjustments_url(member_id: @member.id), notice: 'Salary Adjustment created!' }
	        format.json { render :index, status: :created, location: member_salary_adjustments_url(member_id: @member.id) }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @salary_adjustment.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@member = Member.find(params[:member_id])
			@salary_adjustment = SalaryAdjustment.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@member = Member.find(params[:member_id])
			@salary_adjustment = SalaryAdjustment.find(params[:id])
			respond_to do |format|
	      if @salary_adjustment.update(salary_adjustment_params)
	        format.html { redirect_to member_salary_adjustments_url(member_id: @member.id), notice: 'Salary Adjustment updated!' }
	        format.json { render :index, status: :updated, location: member_salary_adjustments_url(member_id: @member.id) }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @salary_adjustment.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
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