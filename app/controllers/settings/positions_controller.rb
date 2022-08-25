module Settings
	class PositionsController < ApplicationController

		def new
			@position = Position.new
		end

		def create
			@position = Position.create(position_params)
			if @position.save
				redirect_to settings_url, notice: 'Position created!'
			else
				render :new
			end
		end

		def edit
			@position = Position.find(params[:id])
		end

		def update
			@position = Position.find(params[:id])
			@position.update(position_params)
			if @position.save
				redirect_to settings_url, notice: 'Position updated!'
			else
				render :edit
			end
		end

		private

		def position_params
			params.require(:position).permit(:name)
		end
	end
end