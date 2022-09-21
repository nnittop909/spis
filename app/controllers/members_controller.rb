class MembersController < ApplicationController
	respond_to :html, :json, :flash
	
	def index
		if params[:search].present?
			@results = Member.search(params[:search]).order(full_name: :desc)
		elsif params[:year].present?
			@results = QueryByTerm.new(year: params[:year]).query!
		else
			@results = Member.order(full_name: :desc).all
		end
    @members = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def show
		@member = Member.find(params[:id])
	end

	def new
		@member = MemberProcessor.new
	end

	def create
		@member = MemberProcessor.new(member_params)
    if @member.process!
    	redirect_to member_url(@member), notice: 'Member saved!'
    else
    	render :new
    end
	end

	def edit
		@member = Member.find(params[:id])
		@member_processor = MemberProcessor.new("id" => @member.id)
	end

	def update
		@member = Member.find(params[:id])
		@member_processor = MemberProcessor.new(member_params.merge("id" => @member.id))
		if @member_processor.update!
      redirect_to member_url(@member), notice: 'Member updated!'
    else
    	render :edit
    end
	end

	def destroy
		
	end

	private
	def member_params
		params.require(:member_processor).permit(
			:first_name, :last_name, :middle_name, :name_suffix, :birthdate, 
			:address, :contact_number, :educational_attainment_id,
			:civil_status, :civil_service_eligibility_id,
			:other_info, :tin_number, :gsis_number
		)
	end
end