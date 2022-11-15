module Minutes
	class DocumentsController < ApplicationController

		def update
			@minute = Minute.find(params[:minute_id])
			@minute.update(file_params)
			if @minute.save
				redirect_to minute_url(@minute), notice: "File updated!"
			else
				redirect_to minute_url(@minute), alert: "Invalid file type, or size is greater than 100MB."
			end
		end

		def create
			@minute = Minute.find(params[:minute_id])
			@minute.update(file_params)
			if @minute.save
				redirect_to minute_url(@minute), notice: "Document successfully uploaded."
			else
				redirect_to minute_url(@minute), alert: "Invalid file type, or size is greater than 100MB."
			end
		end

		def destroy
			@minute = Minute.find(params[:minute_id])
			@file = @minute.file.purge
			redirect_to minute_url(@minute), notice: 'Document deleted!'
		end

		private

		def file_params
			params.require(:minute).permit(:file)
		end
	end
end