module Users
	class PasswordsController < ApplicationController

	 	def edit
	    @user = current_user
	 	end

		def update
			@user = current_user
			respond_to do |format|
	      if @user.update(password_params)
	      	bypass_sign_in(@user)
	        format.html { redirect_to user_settings_url(user_id: @user.id), notice: "Password changed." }
	      else
	        format.html { render :edit, status: :unprocessable_entity }
	        format.turbo_stream { render :form_update, status: :unprocessable_entity }
	      end
	    end
		end

		private
    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
  end
end