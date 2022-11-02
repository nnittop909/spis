module Settings
	class PositionsController < ApplicationController

		def new
			@position = Position.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@position = Position.new(position_params)
			respond_to do |format|
	      if @position.save
	        format.html { redirect_to settings_url, notice: 'Position created!' }
	        format.json { render :index, status: :created, location: settings_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @position.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@position = Position.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@position = Position.find(params[:id])
			respond_to do |format|
	      if @position.update(position_params)
	        format.html { redirect_to settings_url, notice: 'Position updated!' }
	        format.json { render :index, status: :updated, location: settings_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @position.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		private

		def position_params
			params.require(:position).permit(:name)
		end
	end
end