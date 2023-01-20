module Users
	class AvatarsController < ApplicationController

		def update
			@user = User.find(params[:user_id])
			@user.update(avatar_params)
			if @user.save
				redirect_to user_url(@user), notice: "Avatar updated!"
			else
				redirect_to user_url(@user), alert: "Invalid file type, only accepts images (.jpg, .png, .gif)!"
			end
		end

		private
		def avatar_params
			params.require(:user).permit(:avatar)
		end
	end
end