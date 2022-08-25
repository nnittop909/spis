class CommitteesController < ApplicationController
	
	def index
		if params[:search].present?
			@results = Committee.search(params[:search]).order(current_name: :desc)
		else
			@results = Committee.order(current_name: :desc).all
		end
    @committees = Kaminari.paginate_array(@results).page(params[:page]).per(30)
	end

	def new
		@committee = CommitteeProcessor.new
	end

	def create
		@committee = CommitteeProcessor.new(committee_params)
		respond_to do |format|
      if @committee.process!
        format.html { redirect_to committees_url, notice: "Committee created." }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@committee = Committee.find(params[:id])
		@committee_processor = CommitteeProcessor.new("id" => @committee.id)
	end

	def update
		@committee = Committee.find(params[:id])
		@committee_processor = CommitteeProcessor.new(committee_params.merge("id" => @committee.id))
		respond_to do |format|
      if @committee_processor.update!
        format.html { redirect_to committee_url(@committee), notice: "Committee updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render :form_update, status: :unprocessable_entity }
      end
    end
	end

	def show
		@committee = Committee.find(params[:id])
	end

	def destroy
		@committee = Committee.find(params[:id])
	end

	private

	def committee_params
		params.require(:committee_processor).permit(
			:name, :start_of_term, :end_of_term, :active
		)
	end
end