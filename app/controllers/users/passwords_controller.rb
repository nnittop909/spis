module Users
	class PasswordsController < ApplicationController

	 	def edit
	    @user = current_user
	    respond_to do |format|
	      format.html
	      format.js
	    end
	 	end

		def update
			@user = current_user
			respond_to do |format|
	      if @user.update(password_params)
	        format.html { redirect_to user_settings_url(user_id: @user.id), notice: 'Password changed!' }
	        format.json { render :index, status: :created, location: user_settings_url(user_id: @user.id) }
	        format.js
	      else
	        format.html { render :edit }
	        format.json { render json: @user.errors, status: :unprocessable_entity }
	        format.js { render :edit }
	      end
	    end
		end

		private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end