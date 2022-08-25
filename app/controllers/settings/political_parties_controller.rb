module Settings
	class PoliticalPartiesController < ApplicationController

		def new
			@political_party = PoliticalParty.new
		end

		def create
			@political_party = PoliticalParty.create(political_party_params)
			if @political_party.save
				redirect_to settings_url, notice: 'Political Party created!'
			else
				render :new
			end
		end

		def edit
			@political_party = PoliticalParty.find(params[:id])
		end

		def update
			@political_party = PoliticalParty.find(params[:id])
			@political_party.update(political_party_params)
			if @political_party.save
				redirect_to settings_url, notice: 'Political Party updated!'
			else
				render :edit
			end
		end

		private

		def political_party_params
			params.require(:political_party).permit(:name)
		end
	end
end