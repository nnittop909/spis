module Settings
	class TermSettingsController < ApplicationController

		def new
			@term_setting = TermSetting.new
		end

		def create
			@term_setting = TermSetting.create(term_params)
			if @term_setting.save
				redirect_to settings_url, notice: "Term Setting created!"
			else
				render :new
			end
		end

		def edit
			@term_setting = TermSetting.find(params[:id])
		end

		def update
			@term_setting = TermSetting.find(params[:id])
			@term_setting.update(term_params)
			if @term_setting.save
				redirect_to settings_url, notice: "Term Setting updated!"
			else
				render :edit
			end
		end

		private

		def term_params
			params.require(:term_setting).permit(
				:start_date, :end_date, :number_of_year
			)
		end
	end
end