class MeetingsController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Meeting.search(params[:search]).order(title: :desc).all
		else
			@results = Meeting.order(title: :desc).all
		end
    @meetings = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@meeting = Meeting.new
	end

	def create
		@meeting = Meeting.create(meeting_params)
		respond_to do |format|
      if @meeting.save
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@meeting = Meeting.find(params[:id])
	end

	def update
		@meeting = Meeting.find(params[:id])
		respond_to do |format|
      if @meeting.update(meeting_params)
        format.html { redirect_to meeting_url(@meeting), notice: "Meeting updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def show
		@meeting = Meeting.find(params[:id])
		@documents = @meeting.documents
	end

	private
	def meeting_params
		params.require(:meeting).permit(
			:event_number,
			:event_type,
			:date, 
			:title, 
			:description
		)
	end
end