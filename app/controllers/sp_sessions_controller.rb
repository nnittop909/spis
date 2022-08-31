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
	end

	def create
		@sp_session = SpSession.create(sp_session_params)
		respond_to do |format|
      if @sp_session.save
        format.html { redirect_to sp_session_url(@sp_session), notice: "SpSession saved." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@sp_session = SpSession.find(params[:id])
	end

	def update
		@sp_session = SpSession.find(params[:id])
		respond_to do |format|
      if @sp_session.update(sp_session_params)
        format.html { redirect_to sp_session_url(@sp_session), notice: "SpSession updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def show
		@sp_session = SpSession.find(params[:id])
		@documents = @sp_session.documents
		@committee_reports = @sp_session.committee_reports
	end

	private
	def sp_session_params
		params.require(:sp_session).permit(
			:event_number,
			:event_type,
			:date,
			:description
		)
	end
end