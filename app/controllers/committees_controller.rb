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
		@committee = Committee.new
	end

	def create
		@committee = Committee.create(committee_params)
		respond_to do |format|
      if @committee.save
        format.html { redirect_to committees_url, notice: "Committee created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
	end

	def edit
		@committee = Committee.find(params[:id])
	end

	def update
		@committee = Committee.find(params[:id])
		respond_to do |format|
      if @committee.update(committee_params)
        format.html { redirect_to committee_url(@committee), notice: "Committee updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
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
		params.require(:committee).permit(
			:name
		)
	end
end