class UsersController < ApplicationController

	def index
		if params[:search].present?
			@filtered = User.all.search(params[:search])
		else
			@filtered = User.all
		end
		@users = Kaminari.paginate_array(@filtered).page(params[:page]).per(30)
	end

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
      if @user.update!(update_params)
        format.html { redirect_to user_settings_url(user_id: @user.id), notice: 'User details updated!' }
        format.json { render :index, status: :created, location: user_settings_url(user_id: @user.id) }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        format.js { render :edit }
      end
    end
	end

	def show
		@user = User.find(params[:id])
	end

	private

	def update_params
		params.require(:user).permit(
			:email,
			:username,
			:role,
			:first_name,
			:last_name,
			:office_id
		)
	end
end