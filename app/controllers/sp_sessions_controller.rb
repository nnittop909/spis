class SpSessionsController < ApplicationController
	
	def index
		if params[:search].present?
			@results = SpSession.search(params[:search]).order(title: :desc)
		else
			@results = SpSession.order(title: :desc).all
		end
    @sp_sessions = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@sp_session = SpSession.new
		respond_to do |format|
      format.html
      format.js
    end
	end

	def create
		@sp_session = SpSession.new(sp_session_params)
		respond_to do |format|
      if @sp_session.save
        format.html { redirect_to sp_sessions_url, notice: 'Session created!' }
        format.json { render :index, status: :created, location: sp_sessions_url }
        format.js
      else
        format.html { render :new }
        format.json { render json: @sp_session.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def edit
		@sp_session = SpSession.find(params[:id])
		respond_to do |format|
      format.html
      format.js
    end
	end

	def update
		@sp_session = SpSession.find(params[:id])
		respond_to do |format|
      if @sp_session.update(sp_session_params)
        format.html { redirect_to sp_session_url(@sp_session), notice: 'Session updated!' }
        format.json { render :index, status: :updated, location: sp_session_url(@sp_session) }
        format.js
      else
        format.html { render :new }
        format.json { render json: @sp_session.errors, status: :unprocessable_entity }
        format.js { render :new }
      end
    end
	end

	def show
		@sp_session = SpSession.find(params[:id])
		@documents = @sp_session.documents
		@committee_reports = @sp_session.committee_reports
		@ordinances = @sp_session.considered_ordinances
		@resolutions = @sp_session.considered_resolutions
		@committee_events = @sp_session.committee_events
	end

	private
	def sp_session_params
		params.require(:sp_session).permit(
			:event_number,
			:event_type,
			:date
		)
	end
end