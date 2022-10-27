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
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@member = MemberProcessor.new(member_params)
		respond_to do |format|
      if @member.process!
        format.html { redirect_to members_url, notice: 'Member created!' }
        format.json { render :index, status: :created, location: members_url }
        format.js
      else
        format.html { render :new }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def edit
		@member = Member.find(params[:id])
		@processor = MemberProcessor.new("id" => @member.id)
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@member = Member.find(params[:id])
		@processor = MemberProcessor.new(member_params.merge("id" => @member.id))
		respond_to do |format|
      if @processor.update!
        format.html { redirect_to member_url(@member), notice: 'Member updated!' }
        format.json { render :index, status: :updated, location: member_url(@member) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
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