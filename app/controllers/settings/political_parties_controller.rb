module Settings
	class PoliticalPartiesController < ApplicationController

		def index
			@political_parties = PoliticalParty.all
		end

		def new
			@political_party = PoliticalParty.new
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def create
			@political_party = PoliticalParty.new(political_party_params)
			respond_to do |format|
	      if @political_party.save
	        format.html { redirect_to settings_political_parties_url, notice: 'Party created!' }
	        format.json { render :index, status: :created, location: settings_political_parties_url }
	        format.js
	      else
	        format.html { render :new }
	        format.json { render json: @political_party.errors, status: :unprocessable_entity }
	        format.js { render :new }
	      end
	    end
		end

		def edit
			@political_party = PoliticalParty.find(params[:id])
			respond_to do |format|
	      format.html
	      format.js
	    end
		end

		def update
			@political_party = PoliticalParty.find(params[:id])
			respond_to do |format|
	      if @political_party.update(political_party_params)
	        format.html { redirect_to settings_political_parties_url, notice: 'Party updated!' }
	        format.json { render :index, status: :updated, location: settings_political_parties_url }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @political_party.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		private

		def political_party_params
			params.require(:political_party).permit(:name, :code)
		end
	end
end